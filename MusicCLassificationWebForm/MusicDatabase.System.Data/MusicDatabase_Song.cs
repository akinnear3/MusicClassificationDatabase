using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//using System.ComponentModel.DataAnnotations;
//using System.ComponentModel.DataAnnotations.Schema;

namespace MusicDatabase.System.Data
{
 //   [Table("Songs")]
    public class MusicDatabase_Song
    {
        public int SongID { get; set; }
        public string SongName { get; set; }
        public int FiletypeID { get; set; }
    }
}
