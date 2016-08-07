//
//  iTunesSearchAPI.swift
//  iTunesArtworkExplorer for Mac
//
//  Created by SaitoYuta on 2016/08/06.
//  Copyright © 2016年 SaitoYuta. All rights reserved.
//

import Foundation
import SwiftyJSON
import APIKit

protocol iTunesSearchRequestType: RequestType {
}

extension iTunesSearchRequestType {
    var baseURL:NSURL {
        return NSURL(string: "https://itunes.apple.com/search")!
    }
}

struct iTunesSearchAPI: iTunesSearchRequestType {
    typealias Response = JSON
    var path: String {
        return ""
    }
    var method: HTTPMethod {
        return .GET
    }
    
    enum MediaType {
        case movie(ent: MovieEntityType? , attr: MovieAttributeType? )
        case podcast(ent: PodcastEntityType?, attr: PodcastAttributeType?)
        case music(ent: MusicEntityType?, attr: MusicAttributeType?)
        case musicVideo(ent: MusicVideoEntityType?, attr: MusicVideoAttributeType?)
        case audiobook(ent: AudiobookEntityType?, attr: AudiobookAttributeType?)
        case shortFilm(ent: ShortFilmEntityType?, attr: ShortFilmAttributeType?)
        case tvShow(ent: TvShowEntityType?, attr: TvShowAttributeType?)
        case software(ent: SoftwareEntityType?, attr: SoftwareAttributeType?)
        case ebook(ent: EbookEntityType?)
        case all(ent: AllEntityType?, attr: AllAttributeType?)
        
        enum MovieEntityType {
            case movieArtist, movie
            func toString() -> String {
                switch self {
                case .movieArtist:
                    return "movieArtist"
                case .movie:
                    return "movie"
                }
            }
        }
        
        enum PodcastEntityType {
            case podcastAuthor, podcast
            
            func toString() -> String? {
                switch self {
                case .podcastAuthor:
                    return "podcastAuthor"
                case .podcast:
                    return "podcast"
                }
            }
        }
        
        enum MusicEntityType {
            case musicArtist, musicTrack, album, musicVideo, mix, song
            func toString() -> String {
                switch self {
                case .musicArtist:
                    return "musicArtist:"
                case .musicTrack:
                    return "musicTrack"
                case .album:
                  return "album"
                case .musicVideo:
                  return "musicVideo"
                case .mix:
                  return "mix"
                case .song:
                  return "song"
                }
            }
        }
        enum MusicVideoEntityType {
            case musicArtist, musicVideo
            func toString() -> String? {
                switch self {
                case .musicArtist:
                    return "musicArtist"
                case .musicVideo:
                    return "musicVideo"
                }
            }
        }
        enum AudiobookEntityType {
            case audiobookAuthor, audiobook
            func toString() -> String? {
                switch self {
                case .audiobookAuthor:
                    return "audiobookAuthor"
                case .audiobook:
                    return "audiobook"
                }
            }
        }
        enum ShortFilmEntityType {
            case shortFilmArtist, shortFilm
            func toString() -> String? {
                switch self {
                case .shortFilmArtist:
                    return "shortFilmArtist"
                case .shortFilm:
                    return "shortFilm"
                }
            }
        }
        enum TvShowEntityType {
            case tvEpisode, tvSeason
            func toString() -> String? {
                switch self {
                case .tvEpisode:
                    return "tvEpisode"
                case .tvSeason:
                    return "tvSeason"
                }
            }
        }
        enum SoftwareEntityType {
            case software, iPadSoftware, macSoftware
            func toString() -> String? {
                switch self {
                case .software:
                    return "software"
                case .iPadSoftware:
                    return "iPadSoftware"
                case .macSoftware:
                    return "macSoftware"
                }
            }
        }
        enum EbookEntityType {
            case ebook
            func toString() -> String? {
                switch self {
                case .ebook:
                    return "ebook"
                }
            }
        }
        enum AllEntityType {
            case movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack
            func toString() -> String? {
                switch self {
                case .movie:
                    return "movie"
                case .album:
                    return "album"
                case .allArtist:
                  return "allArtist"
                case .podcast:
                  return "podcast"
                case .musicVideo:
                  return "musicVideo"
                case .mix:
                  return "mix"
                case .audiobook:
                  return "audiobook"
                case .tvSeason:
                  return "rvSeason"
                case .allTrack:
                  return "allTrack"
                }
            }
        }
        
        enum MovieAttributeType {
            case actorTerm, genreIndex, artistTerm, shortFilmTerm, producerTerm, ratingTerm, directorTerm, releaseYearTerm, featureFilmTerm, movieArtistTerm, movieTerm, ratingIndex, descriptionTerm
            func toString() -> String? {
                switch self {
                case .actorTerm:
                    return "actorTerm"
                case .genreIndex:
                    return "genreIndex"
                case .artistTerm:
                  return "artistTerm"
                case .shortFilmTerm:
                  return "shortFilmTerm"
                case .producerTerm:
                  return "producerTerm"
                case .ratingTerm:
                  return "ratingTerm"
                case .directorTerm:
                  return "directorTerm"
                case .releaseYearTerm:
                  return "releaseYearTerm"
                case .featureFilmTerm:
                  return "featureFilmTerm"
                case .movieArtistTerm:
                  return "movieArtistTerm"
                case .movieTerm:
                  return "movieTerm"
                case .ratingIndex:
                  return "ratingIndex"
                case .descriptionTerm:
                  return "descriptionTerm"
                }
            }
        }
        enum PodcastAttributeType {
            case titleTerm, languageTerm, authorTerm, genreIndex, artistTerm, ratingIndex, keywordsTerm, descriptionTerm
            func toString() -> String? {
                switch self {
                case .titleTerm:
                    return "titleTerm"
                case .languageTerm:
                    return "languageTerm"
                case .authorTerm:
                  return "authorTerm"
                case .genreIndex:
                  return "genreIndex"
                case .artistTerm:
                  return "artistTerm"
                case .ratingIndex:
                  return "ratingIndex"
                case .keywordsTerm:
                    return "keywordsTerm"
                case .descriptionTerm:
                    return "descriptionTerm"
                }
            }
        }
        enum MusicAttributeType {
            case mixTerm, genreIndex, artistTerm, composerTerm, albumTerm, ratingIndex, songTerm
            func toString() -> String? {
                switch self {
                case .mixTerm:
                    return "mixTerm"
                case .genreIndex:
                    return "genreIndex"
                case .artistTerm:
                    return "artistTerm"
                case .composerTerm:
                    return "composerTerm"
                case .albumTerm:
                    return "albumTerm"
                case .ratingIndex:
                    return "ratingIndex"
                case .songTerm:
                    return "songTerm"
                }
            }
        }
        enum MusicVideoAttributeType {
            case genreIndex, artistTerm, albumTerm, ratingIndex, songTerm
            func toString() -> String? {
                switch self {
                case .genreIndex:
                    return "genreIndex"
                case .artistTerm:
                    return "artistTerm"
                case .albumTerm:
                    return "albumTerm"
                case .ratingIndex:
                    return "ratingIndex"
                case .songTerm:
                    return "songTerm"
                }
            }
        }
        enum AudiobookAttributeType {
            case titleTerm, authorTerm, genreIndex, ratingIndex
            func toString() -> String? {
                switch self {
                case .titleTerm:
                    return "titleTerm"
                case .authorTerm:
                    return "authorTerm"
                case .genreIndex:
                    return "genreIndex"
                case .ratingIndex:
                    return "ratingIndex"
                }
            }
        }
        enum ShortFilmAttributeType {
            case genreIndex, artistTerm, shortFilmTerm, ratingIndex, descriptionTerm
            func toString() -> String? {
                switch self {
                case .genreIndex:
                    return "genreIndex"
                case .artistTerm:
                    return "artistTerm"
                case .shortFilmTerm:
                    return "shortFilmTerm"
                case .ratingIndex:
                    return "ratingIndex"
                case .descriptionTerm:
                    return "descriptionTerm"
                }
            }
        }
        enum TvShowAttributeType {
            case genreIndex, tvEpisodeTerm, showTerm, tvSeasonTerm, ratingIndex, descriptionTerm
            func toString() -> String? {
                switch self {
                case .genreIndex:
                    return "genreIndex"
                case .tvEpisodeTerm:
                    return "tvSeasonTerm"
                case .showTerm:
                    return "showTerm"
                case .tvSeasonTerm:
                    return "tvSeasonTerm"
                case .ratingIndex:
                    return "ratingIndex"
                case .descriptionTerm:
                    return "descriptionTerm"
                }
            }
        }
        enum SoftwareAttributeType {
            case softwareDeveloper
            func toString() -> String? {
                switch self {
                case .softwareDeveloper:
                    return "softwareDeveloper"
                }
            }
        }
        enum AllAttributeType {
            case actorTerm, languageTerm, allArtistTerm, tvEpisodeTerm, shortFilmTerm, directorTerm, releaseYearTerm, titleTerm, featureFilmTerm, ratingIndex, keywordsTerm, descriptionTerm, authorTerm, genreIndex, mixTerm, allTrackTerm, artistTerm, composerTerm, tvSeasonTerm, producerTerm, ratingTerm, songTerm, movieArtistTerm, showTerm, movieTerm, albumTerm
            func toString() -> String? {
                switch self {
                case .actorTerm:
                    return "actorTerm"
                case .languageTerm:
                    return "languageTerm"
                case .allArtistTerm:
                    return "allArtistTerm"
                case .tvEpisodeTerm:
                    return "tvEpisodeTerm"
                case .shortFilmTerm:
                    return "shortFilmTerm"
                case .directorTerm:
                    return "directorTerm"
                case .releaseYearTerm:
                    return "releaseYearTerm"
                case .titleTerm:
                    return "titleTerm"
                case .featureFilmTerm:
                    return "featureFilmTerm"
                case .ratingIndex:
                    return "ratingIndex"
                case .keywordsTerm:
                    return "keywordsTerm"
                case .descriptionTerm:
                    return "descriptionTerm"
                case .authorTerm:
                    return "authorTerm"
                case .genreIndex:
                    return "genreIndex"
                case .mixTerm:
                    return "mixTerm"
                case .allTrackTerm:
                    return "allTrackTerm"
                case .artistTerm:
                    return "artistTerm"
                case .composerTerm:
                    return "composerTerm"
                case .tvSeasonTerm:
                    return "tvSeasonTerm"
                case .producerTerm:
                    return "producerTerm"
                case .ratingTerm:
                    return "ratingTerm"
                case .songTerm:
                    return "songTerm"
                case .movieArtistTerm:
                    return "movieArtistTerm"
                case .showTerm:
                    return "showTerm"
                case .movieTerm:
                    return "movieTerm"
                case .albumTerm:
                    return "albumTerm"
                }
            }
        }
        
        func toString() -> String {
            switch self {
            case .movie:
                return "movie"
            case .podcast:
                return "podcast"
            case .music:
                return "music"
            case .musicVideo:
                return "musicVideo"
            case .audiobook:
                return "audiobook"
            case .shortFilm:
                return "shortFilm"
            case .tvShow:
                return "tvShow"
            case .software:
                return "software"
            case .ebook:
                return "ebook"
            case .all:
                return "all"
            }
        }
    }
    
    enum LangType: String {
        case En = "en_us", Ja = "ja_jp"
    }
    enum CountryType: String {
        case ad = "ad",ae = "ae",af = "af",ag = "ag",ai = "ai",al = "al",am = "am",ao = "ao",aq = "aq",ar = "ar",`as` = "as",at = "at",au = "au",aw = "aw",ax = "ax",az = "az",ba = "ba",bb = "bb",bd = "bd",be = "be",bf = "bf",bg = "bg",bh = "bh",bi = "bi",bj = "bj",bl = "bl",bm = "bm",bn = "bn",bo = "bo",bq = "bq",br = "br",bs = "bs",bt = "bt",bv = "bv",bw = "bw",by = "by",bz = "bz",ca = "ca",cc = "cc",cd = "cd",cf = "cf",cg = "cg",ch = "ch",ci = "ci",ck = "ck",cl = "cl",cm = "cm",cn = "cn",co = "co",cr = "cr",cu = "cu",cv = "cv",cw = "cw",cx = "cx",cy = "cy",cz = "cz",de = "de",dj = "dj",dk = "dk",dm = "dm",`do` = "do",dz = "dz",ec = "ec",ee = "ee",eg = "eg",eh = "eh",er = "er",es = "es",et = "et",fi = "fi",fj = "fj",fk = "fk",fm = "fm",fo = "fo",fr = "fr",ga = "ga",gb = "gb",gd = "gd",ge = "ge",gf = "gf",gg = "gg",gh = "gh",gi = "gi",gl = "gl",gm = "gm",gn = "gn",gp = "gp",gq = "gq",gr = "gr",gs = "gs",gt = "gt",gu = "gu",gw = "gw",gy = "gy",hk = "hk",hm = "hm",hn = "hn",hr = "hr",ht = "ht",hu = "hu",id = "id",ie = "ie",il = "il",im = "im",`in` = "in",io = "io",iq = "iq",ir = "ir",`is` = "is",it = "it",je = "je",jm = "jm",jo = "jo",jp = "jp",ke = "ke",kg = "kg",kh = "kh",ki = "ki",km = "km",kn = "kn",kp = "kp",kr = "kr",kw = "kw",ky = "ky",kz = "kz",la = "la",lb = "lb",lc = "lc",li = "li",lk = "lk",lr = "lr",ls = "ls",lt = "lt",lu = "lu",lv = "lv",ly = "ly",ma = "ma",mc = "mc",md = "md",me = "me",mf = "mf",mg = "mg",mh = "mh",mk = "mk",ml = "ml",mm = "mm",mn = "mn",mo = "mo",mp = "mp",mq = "mq",mr = "mr",ms = "ms",mt = "mt",mu = "mu",mv = "mv",mw = "mw",mx = "mx",my = "my",mz = "mz",na = "na",nc = "nc",ne = "ne",nf = "nf",ng = "ng",ni = "ni",nl = "nl",no = "no",np = "np",nr = "nr",nu = "nu",nz = "nz",om = "om",pa = "pa",pe = "pe",pf = "pf",pg = "pg",ph = "ph",pk = "pk",pl = "pl",pm = "pm",pn = "pn",pr = "pr",ps = "ps",pt = "pt",pw = "pw",py = "py",qa = "qa",re = "re",ro = "ro",rs = "rs",ru = "ru",rw = "rw",sa = "sa",sb = "sb",sc = "sc",sd = "sd",se = "se",sg = "sg",sh = "sh",si = "si",sj = "sj",sk = "sk",sl = "sl",sm = "sm",sn = "sn",so = "so",sr = "sr",ss = "ss",st = "st",sv = "sv",sx = "sx",sy = "sy",sz = "sz",tc = "tc",td = "td",tf = "tf",tg = "tg",th = "th",tj = "tj",tk = "tk",tl = "tl",tm = "tm",tn = "tn",to = "to",tr = "tr",tt = "tt",tv = "tv",tw = "tw",tz = "tz",ua = "ua",ug = "ug",um = "um",us = "us",uy = "uy",uz = "uz",va = "va",vc = "vc",ve = "ve",vg = "vg",vi = "vi",vn = "vn",vu = "vu",wf = "wf",ws = "ws",ye = "ye",yt = "yt",za = "za",zm = "zm",zw = "zw"
    }
    
    var term: String
    var country: CountryType
    var media: MediaType?
    var limit: Int?
    var lang: LangType?
    
    
    var parameters: [String:AnyObject] {
        var parameters: [String:String] = [:]
        parameters["term"] = term
        parameters["country"] = country.rawValue
         _ = media.map {
            switch $0 {
            case .movie(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .podcast(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .music(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .musicVideo(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .audiobook(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .shortFilm(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .tvShow(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .software(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            case .ebook(let ent):
                _ = ent.map { parameters["entity"] = $0.toString() }
            case .all(let ent, let attr):
                _ = ent.map { parameters["entity"] = $0.toString() }
                _ = attr.map { parameters["attribute"] = $0.toString() }
            }
            
            parameters["media"] = $0.toString()
        }
        _ = limit.map { parameters["limit"] = $0.description }
        _ = lang.map { parameters["lang"] = $0.rawValue }
        
        return parameters
    }
    
    init(
        term: String,
        country: CountryType,
        media: MediaType? = nil,
        limit: Int? = nil,
        lang: LangType? = nil
        )
    {
        self.term = term
        self.country = country
        self.media = media
        self.limit = limit
        self.lang = lang
        
    }
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> iTunesSearchAPI.Response? {
        return JSON(object)
    }
}