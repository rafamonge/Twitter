using System;
using System.Collections.Generic;
using System.Configuration;

namespace TwitterDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            var twitter = new Twitter
            {
                OAuthConsumerKey = ConfigurationManager.AppSettings["ConsumerKey"],
                OAuthConsumerSecret = ConfigurationManager.AppSettings["ConsumerSecretKey"]
            };
            IEnumerable<string> twitts = twitter.GetTwitts("AnaAne4kaAnutka", 10).Result;
            foreach (var t in twitts)
            {
                Console.WriteLine(t + "\n");
            }
            Console.ReadKey();
        }
    }
}
