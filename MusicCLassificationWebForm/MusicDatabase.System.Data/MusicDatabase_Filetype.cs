using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//using System.ComponentModel.DataAnnotations;
//using System.ComponentModel.DataAnnotations.Schema;

namespace MusicDatabase.System.Data
{
    public class MusicDatabase_Filetype
    {
        public int filetypeID { get; set; }
        public string filetype { get; set; }

        public MusicDatabase_Filetype()
        {

        }
        public MusicDatabase_Filetype(int ftpID, string ftp)
        {
            filetype = ftp;
            filetypeID = ftpID;
        }

        public static explicit operator MusicDatabase_Filetype(DataRow r)
        {
            return new MusicDatabase_Filetype(r.Field<int>("filetypeID"), r.Field<string>("filetype"));
        }
    }
}
