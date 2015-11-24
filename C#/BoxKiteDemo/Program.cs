using System.Configuration;
using System.Linq;
using BoxKite.Twitter.Models;
using BoxKiteDemo.Helpers;

namespace BoxKiteDemo
{
    public class Program
    {
        static void Main(string[] args)
        {
            var consumerKey = ConfigurationManager.AppSettings["ConsumerKey"];
            var consumerSecret = ConfigurationManager.AppSettings["ConsumerSecretKey"];
            BoxKiteTwitterFromConsole.GetTweets(consumerKey, consumerSecret);
            
            
            var tweets = FolderDeserialzer.Deserialize<Tweet>("WorkingDir").ToList();
            Queries.GetHashtagFrequency(tweets);
            Queries.GetUserFrequency(tweets);

        }

    }
}
