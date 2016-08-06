using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Collections;

namespace iTunesArtworkExplorer
{
    public partial class iTunesArtworkExplorer : Form
    {
        Form1Model model;
        Timer timer;

        public iTunesArtworkExplorer()
        {
            InitializeComponent();

            this.apiResultGridView.Columns.AddRange(new DataGridViewImageColumn[]{
                this.artworkDataGridViewTextBoxColumn
            });
            this.apiResultGridView.Columns.AddRange(new DataGridViewTextBoxColumn[]{
                this.titleDataGridViewTextBoxColumn,
                this.artistDataGridViewTextBoxColumn,
                this.idDataGridViewTextBoxColumn
            });

            apiResultGridView.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            apiResultGridView.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells;
            dt.Columns.Add("Artwork", typeof(Image));
            dt.Columns.Add("Artist");
            dt.Columns.Add("Title");
            dt.Columns.Add("trackID");
            this.model = new Form1Model();
            this.model.imageURLs = new Dictionary<string, string>();
            reloadData();

            timer = new Timer();
            timer.Tick += Timer_Tick;
            timer.Interval = 1000;
            timer.Enabled = true;
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            reloadData();
        }

        private void reloadData()
        {
            var track = iTunesControllerAPI.getTrack();
            if (track == null) return;
            if (this.model.trackName == track.Name) return;
            this.artworkPictureBox.Image = iTunesControllerAPI.getArtwork();
            this.artworkPictureBox.SizeMode = PictureBoxSizeMode.StretchImage;

            this.trackNameLabel.Text = track.Name;
            this.trackArtistLabel.Text = track.Artist;


            this.model.trackName = track.Name;
            this.queryTextBox.Text = $"{track.Name} {track.Artist}";
            var api = new iTunesAPI();
            dynamic data = api.getSearchResult($"{track.Name} {track.Artist}");
            this.dt.Clear();
            if (data == null) return;


            foreach (var item in data.results)
            {
                DataRow row = this.dt.NewRow();
                this.model.imageURLs[item.trackId.ToString() as string] = item.artworkUrl100;
                Image img = loadImageFromURL(item.artworkUrl100.ToString() as string);
                string artwork = item.artworkUrl100.ToString() as string;
                string title = item.trackCensoredName.ToString() as string;
                string artist = item.artistName.ToString() as string;

                row["Artwork"] = img;
                row["Title"] = item.trackCensoredName.ToString() as string;
                row["Artist"] = item.artistName.ToString() as string;
                row["trackID"] = item.trackId;
                this.dt.Rows.Add(row);
            }

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView g = sender as DataGridView;
            int row = e.RowIndex;
            if (row < 0) return;
            var key = g.Rows[row].Cells[3].Value.ToString();

            var url = this.model.imageURLs[key].Replace("100","1400");
            Debug.WriteLine(url as string);
            Image img = loadImageFromURL(url as string);
            iTunesControllerAPI.setTrack(img);
            Debug.WriteLine(g.Rows[row].Cells[1].Value);
        }
        //---------------------------------------------------------------------------
        /// <summary>
        /// 指定されたURLの画像をImage型オブジェクトとして取得する
        /// </summary>
        /// <param name="url">画像データのURL(ex: http://example.com/foo.jpg) </param>
        /// <returns>         画像データ</returns>
        //---------------------------------------------------------------------------
        public static System.Drawing.Image loadImageFromURL( string url ) { 
          int buffSize = 65536; // 一度に読み込むサイズ
          MemoryStream imgStream = new MemoryStream();

          //------------------------
          // パラメータチェック
          //------------------------
          if ( url == null || url.Trim().Length <= 0 ) {
            return null;
          }

          //----------------------------
          // Webサーバに要求を投げる
          //----------------------------
          WebRequest req = WebRequest.Create( url );
          BinaryReader reader = new BinaryReader( req.GetResponse().GetResponseStream() );

          //--------------------------------------------------------
          // Webサーバからの応答データを取得し、imgStreamに保存する
          //--------------------------------------------------------
          while ( true ) {
            byte[] buff = new byte[ buffSize ];

            // 応答データの取得
            int readBytes = reader.Read( buff, 0, buffSize );
            if ( readBytes <= 0 ) {
              // 最後まで取得した->ループを抜ける
              break;
            }

            // バッファに追加
            imgStream.Write( buff, 0, readBytes );
          }

          return new Bitmap( imgStream );
        }

        public void SearchButton_Click(object sender, System.EventArgs e)
        {
            string query = this.queryTextBox.Text;

            var api = new iTunesAPI();
            dynamic data = api.getSearchResult(query);
            this.dt.Clear();
            if (data == null) return;


            foreach (var item in data.results)
            {
                DataRow row = this.dt.NewRow();
                this.model.imageURLs[item.trackId.ToString() as string] = item.artworkUrl100;
                Image img = loadImageFromURL(item.artworkUrl100.ToString() as string);
                string artwork = item.artworkUrl100.ToString() as string;
                string title = item.trackCensoredName.ToString() as string;
                string artist = item.artistName.ToString() as string;

                row["Artwork"] = img;
                row["Title"] = item.trackCensoredName.ToString() as string;
                row["Artist"] = item.artistName.ToString() as string;
                row["trackID"] = item.trackId;
                this.dt.Rows.Add(row);
            }

        }
    }
}
