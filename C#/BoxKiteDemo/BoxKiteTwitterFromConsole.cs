// (c) 2012-2014 Nick Hodge mailto:hodgenick@gmail.com & Brendan Forster
// License: MS-PL

using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;
using BoxKite.Twitter;
using BoxKite.Twitter.Console;
using BoxKite.Twitter.Models;
using Newtonsoft.Json;

namespace BoxKiteDemo
{
    public class BoxKiteTwitterFromConsole
    {
        public static TwitterConnection TwitterConnection;

        public static void GetTweets(string consumerKey, string consumerSecret)
        {
            ConsoleOutput.PrintMessage("Welcome to BoxKite.Twitter Console");
            ConsoleOutput.PrintMessage("(control-c ends)");
            System.Console.CancelKeyPress += cancelStreamHandler;

            TwitterCredentials twittercredentials = null;

            TwitterConnection = new TwitterConnection(consumerKey, consumerSecret);

            // PIN based authentication
            var oauth = TwitterConnection.BeginUserAuthentication().Result;

            // if the response is null, something is wrong with the initial request to OAuth
            if (!string.IsNullOrWhiteSpace(oauth))
            {
                ConsoleOutput.PrintMessage("Pin: ");
                var pin = System.Console.ReadLine();
                twittercredentials = TwitterConnection.CompleteUserAuthentication(pin, oauth).Result;

                ManageTwitterCredentials.SaveTwitterCredentialsToFile(twittercredentials);
            }
            else
            {
                ConsoleOutput.PrintError("Cannot OAuth with Twitter");
            }

            GetTweets(twittercredentials);

            ConsoleOutput.PrintMessage("All Finished");
            System.Console.ReadLine();
        }

        private static void GetTweets(TwitterCredentials twittercredentials)
        {
            if (twittercredentials != null)
            {
                TwitterConnection = new TwitterConnection(twittercredentials);

                TwitterConnection.StartUserStreaming();

                ConsoleOutput.PrintMessage(TwitterConnection.TwitterCredentials.ScreenName +" is authorised to use BoxKite.Twitter.");

                var usersession = TwitterConnection.UserSession;
                var userstream = TwitterConnection.UserStream;
                var applicationsession = TwitterConnection.ApplicationSession;

                new List<Tweet>();

                var searchstream = usersession.StartSearchStream(track: "Intel");
                searchstream.FoundTweets.Subscribe(ProcessTweet);
                searchstream.Start();

                Thread.Sleep(TimeSpan.FromMinutes(120));
                searchstream.CancelStream.Cancel();
                searchstream.Stop(); 
            }
        }

        public static  void ProcessTweet(Tweet t)
        {
            ConsoleOutput.PrintTweet(t);
            var file = Path.Combine("WorkingDir",String.Format("{0}.json", t.Id));
            var serializedTweet = Newtonsoft.Json.JsonConvert.SerializeObject(t, Formatting.Indented);
            File.WriteAllText(file, serializedTweet, Encoding.UTF8);
        }


        public static void PrintTwitterErrors(TwitterControlMessage tcm)
        {
            ConsoleOutput.PrintMessage("START: TWITTER CONTROL MESSAGE");
            ConsoleOutput.PrintError(String.Format("http reason: {0}", tcm.http_reason));
            ConsoleOutput.PrintError(String.Format("http status code: {0}", tcm.http_status_code));
            ConsoleOutput.PrintError(String.Format("twitter error code: {0}", tcm.twitter_error_code));
            ConsoleOutput.PrintError(String.Format("twitter error message: {0}", tcm.twitter_error_message));
            ConsoleOutput.PrintError(String.Format("API rates: {0}/{1} Resets {2}",
                tcm.twitter_rate_limit_remaining,
                tcm.twitter_rate_limit_limit, tcm.twitter_rate_limit_reset));
            ConsoleOutput.PrintMessage("END: TWITTER CONTROL MESSAGE");
        }

        private static void cancelStreamHandler(object sender, ConsoleCancelEventArgs e)
        {
            ConsoleOutput.PrintMessage("All finished.", ConsoleColor.Blue);
            Thread.Sleep(TimeSpan.FromSeconds(1.3));
        }
    }
}
