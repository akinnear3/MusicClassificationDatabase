using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//using System.ComponentModel.DataAnnotations;
//using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.ComponentModel;

namespace MusicDatabase.System.Data
{
    public class MusicDatabase_Artist
    {
        /// <summary>
        /// the ID associated with the table
        /// </summary>
        private int _artistID;

        public int ArtistID
        {
            get
            {
                return _artistID;
            }

            set
            {
                _artistID = value;
            }
        }

        /// <summary>
        /// the name of the artist
        /// </summary>
        private string _name;
        public string Name
        {
            get
            {
                return _name;
            }

            set
            {
                _name = value;
            }
        }

        /// <summary>
        /// set or change all of the information of an artist
        /// </summary>
        /// <param name="artistID"></param>
        /// <param name="name"></param>
        public void ChangeInfo(int artistID, string name)
        {
            ArtistID = artistID;
            Name = name;
        }

        /// <summary>
        /// alternative way to change all of the information of an artist
        /// </summary>
        /// <param name="info"></param>
        public void ChangeInfo(DataRow info)
        {
            ChangeInfo(info.Field<int>("ArtistID"), info.Field<string>("Name"));
        }

    }
}
