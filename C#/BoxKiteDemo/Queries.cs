using System.Collections.Generic;
using System.Linq;
using BoxKite.Twitter.Models;
using BoxKiteDemo.Helpers;

namespace BoxKiteDemo
{
    class Queries
    {
        public static void GetHashtagFrequency(IEnumerable<Tweet> tweets)
        {

            var hashtags = tweets
                .SelectMany(q => q.Entities.Hashtags.Select(t => t.Text))
                .GroupBy(t => t);
            var counts = hashtags
                .Select(t =>new{t.Key, Count = t.Count()})
                .OrderByDescending(t=>t.Count).ToList();

            counts.WriteSequenceToFile("Hashtagcs.csv");
            
        }


        public static void GetUserFrequency(IEnumerable<Tweet> tweets)
        {
            var hashtags = tweets
                .Select(q => q.User.ScreenName)
                .GroupBy(t => t);
            var counts = hashtags
                .Select(t => new { t.Key, Count = t.Count() })
                .OrderByDescending(t => t.Count).ToList();

            counts.WriteSequenceToFile("Users.csv");
        }
    }
}
