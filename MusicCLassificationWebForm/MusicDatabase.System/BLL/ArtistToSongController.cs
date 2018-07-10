using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data.SqlTypes;

using MusicDatabase.System.DAL;
using MusicDatabase.System.Data;

namespace MusicDatabase.System.BLL
{
    [DataObject]
    public class ArtistToSongController
    {
        #region Create
        public void CreateReference(int songID, int artistID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec AddArtistToSong " + songID + ", " + artistID);
            }
        }
        #endregion
        #region Read
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable GetArtistToSongInfo(int songID)
        {
            using(MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("fetchArtistsBySongID " + songID);
            }
        }

        public bool CheckRefExists(int songID, int artistID)
        {
            using (MusicContext context = new MusicContext())
            {
                //if the rowcount is 0; then it doesn't exist and returns false; otherwise it does exist and returns true. 
                return context.Exec<DataTable>("Exec CheckArtistToSong " + songID + ", " + artistID).Rows.Count != 0;
            }
        }
        #endregion
        #region Update
        #endregion
        #region Delete
        /// <summary>
        /// this deletes references between Artists and the selected song
        /// </summary>
        /// <param name="songID"></param>
        public void DeleteReferences(int songID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec<DataTable>("RemoveArtistReferencesBySong " + songID);
            }
        }

        public void RemoveReference(int songID, int artistID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec DeleteArtistToSong " + songID + ", " + artistID);
            }
        }
        #endregion
    }
}
