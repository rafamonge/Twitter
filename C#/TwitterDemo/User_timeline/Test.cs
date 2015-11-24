using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TwitterDemo.User_timeline
{
  public class User
    {
        public int id { get; set; }
        public string id_str { get; set; }
    }

    public class Hashtag
    {
        public string text { get; set; }
        public IList<int> indices { get; set; }
    }

    public class UserMention
    {
        public string screen_name { get; set; }
        public string name { get; set; }
        public object id { get; set; }
        public string id_str { get; set; }
        public IList<int> indices { get; set; }
    }

    public class Url
    {
        public string url { get; set; }
        public string expanded_url { get; set; }
        public string display_url { get; set; }
        public IList<int> indices { get; set; }
    }

    public class Small
    {
        public int w { get; set; }
        public int h { get; set; }
        public string resize { get; set; }
    }

    public class MediumSize
    {
        public int w { get; set; }
        public int h { get; set; }
        public string resize { get; set; }
    }

    public class Thumb
    {
        public int w { get; set; }
        public int h { get; set; }
        public string resize { get; set; }
    }

    public class Large
    {
        public int w { get; set; }
        public int h { get; set; }
        public string resize { get; set; }
    }

    public class Sizes
    {
        public Small small { get; set; }
        public MediumSize medium { get; set; }
        public Thumb thumb { get; set; }
        public Large large { get; set; }
    }

    public class Medium
    {
        public double id { get; set; }
        public string id_str { get; set; }
        public IList<int> indices { get; set; }
        public string media_url { get; set; }
        public string media_url_https { get; set; }
        public string url { get; set; }
        public string display_url { get; set; }
        public string expanded_url { get; set; }
        public string type { get; set; }
        public Sizes sizes { get; set; }
        public double source_status_id { get; set; }
        public string source_status_id_str { get; set; }
        public long source_user_id { get; set; }
        public string source_user_id_str { get; set; }
        public VideoInfo video_info { get; set; }
    }

    public class Entities
    {
        public IList<Hashtag> hashtags { get; set; }
        public IList<object> symbols { get; set; }
        public IList<UserMention> user_mentions { get; set; }
        public IList<Url> urls { get; set; }
        public IList<Medium> media { get; set; }
    }

    public class BoundingBox
    {
        public string type { get; set; }
        public IList<IList<IList<double>>> coordinates { get; set; }
    }

    public class Attributes
    {
    }

    public class Place
    {
        public string id { get; set; }
        public string url { get; set; }
        public string place_type { get; set; }
        public string name { get; set; }
        public string full_name { get; set; }
        public string country_code { get; set; }
        public string country { get; set; }
        public IList<object> contained_within { get; set; }
        public BoundingBox bounding_box { get; set; }
        public Attributes attributes { get; set; }
    }

    public class Variant
    {
        public int bitrate { get; set; }
        public string content_type { get; set; }
        public string url { get; set; }
    }

    public class VideoInfo
    {
        public IList<int> aspect_ratio { get; set; }
        public IList<Variant> variants { get; set; }
        public int? duration_millis { get; set; }
    }



    public class ExtendedEntities
    {
        public IList<Medium> media { get; set; }
    }

    public class QuotedStatus
    {
        public string created_at { get; set; }
        public double id { get; set; }
        public string id_str { get; set; }
        public string text { get; set; }
        public string source { get; set; }
        public bool truncated { get; set; }
        public object in_reply_to_status_id { get; set; }
        public object in_reply_to_status_id_str { get; set; }
        public object in_reply_to_user_id { get; set; }
        public object in_reply_to_user_id_str { get; set; }
        public object in_reply_to_screen_name { get; set; }
        public  User user { get; set; }
        public object geo { get; set; }
        public object coordinates { get; set; }
        public object place { get; set; }
        public object contributors { get; set; }
        public bool is_quote_status { get; set; }
        public int retweet_count { get; set; }
        public int favorite_count { get; set; }
        public  Entities entities { get; set; }
        public  ExtendedEntities extended_entities { get; set; }
        public bool favorited { get; set; }
        public bool retweeted { get; set; }
        public bool possibly_sensitive { get; set; }
        public string lang { get; set; }
    }

    public class RetweetedStatus
    {
        public string created_at { get; set; }
        public double id { get; set; }
        public string id_str { get; set; }
        public string text { get; set; }
        public string source { get; set; }
        public bool truncated { get; set; }
        public double? in_reply_to_status_id { get; set; }
        public string in_reply_to_status_id_str { get; set; }
        public int? in_reply_to_user_id { get; set; }
        public string in_reply_to_user_id_str { get; set; }
        public string in_reply_to_screen_name { get; set; }
        public  User user { get; set; }
        public object geo { get; set; }
        public object coordinates { get; set; }
        public Place place { get; set; }
        public object contributors { get; set; }
        public bool is_quote_status { get; set; }
        public int retweet_count { get; set; }
        public int favorite_count { get; set; }
        public  Entities entities { get; set; }
        public bool favorited { get; set; }
        public bool retweeted { get; set; }
        public bool possibly_sensitive { get; set; }
        public string lang { get; set; }
        public ExtendedEntities extended_entities { get; set; }
        public double? quoted_status_id { get; set; }
        public string quoted_status_id_str { get; set; }
        public QuotedStatus quoted_status { get; set; }
    }

    public class Tweet
    {
        public string created_at { get; set; }
        public double id { get; set; }
        public string id_str { get; set; }
        public string text { get; set; }
        public string source { get; set; }
        public bool truncated { get; set; }
        public object in_reply_to_status_id { get; set; }
        public object in_reply_to_status_id_str { get; set; }
        public object in_reply_to_user_id { get; set; }
        public object in_reply_to_user_id_str { get; set; }
        public object in_reply_to_screen_name { get; set; }
        public User user { get; set; }
        public object geo { get; set; }
        public object coordinates { get; set; }
        public object place { get; set; }
        public object contributors { get; set; }
        public bool is_quote_status { get; set; }
        public int retweet_count { get; set; }
        public int favorite_count { get; set; }
        public Entities entities { get; set; }
        public bool favorited { get; set; }
        public bool retweeted { get; set; }
        public bool possibly_sensitive { get; set; }
        public string lang { get; set; }
        public RetweetedStatus retweeted_status { get; set; }
        public double? quoted_status_id { get; set; }
        public string quoted_status_id_str { get; set; }
        public QuotedStatus quoted_status { get; set; }
        public  ExtendedEntities extended_entities { get; set; }
    }
}
