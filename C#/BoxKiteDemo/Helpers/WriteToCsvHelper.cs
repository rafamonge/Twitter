using System.Collections.Generic;
using System.IO;
using CsvHelper;

namespace BoxKiteDemo.Helpers
{
    public static class WriteToCsvHelper
    {

        public static void WriteSequenceToFile<T>(this IEnumerable<T> sequence, string path)
        {
            using (var writer = new CsvWriter(new StreamWriter(new FileStream(path, FileMode.Create))))
            {
                writer.WriteRecords(sequence);
            }
        }
    }
}
