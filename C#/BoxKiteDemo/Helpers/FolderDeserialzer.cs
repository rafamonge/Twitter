using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BoxKite.Twitter.Models;
using Newtonsoft.Json;

namespace BoxKiteDemo.Helpers
{//\661930855187615745.json"
    public class FolderDeserialzer
    {
        public static IEnumerable<T> Deserialize<T>(string path)
        {
            if (!Directory.Exists(path))
                return null;
            var files = Directory.EnumerateFiles(path).OrderBy(q=>q);
            return files.Select(file => JsonConvert.DeserializeObject<T>(File.ReadAllText(file)));

        }
    }
}
