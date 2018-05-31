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
    public class GenreToSongController
    {
        #region Create
        public void CreateReference(int songID, int genreID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec AddGenreToSong " + songID + ", " + genreID);
            }
        }
        #endregion
        #region Read
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable GetGenreToSongInfo(int songID)
        {
            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("fetchGenreBySongID " + songID);
            }
        }
        #endregion
        #region Update
        #endregion
        #region Delete
        /// <summary>
        /// this deletes references between Genre and the selected song
        /// </summary>
        /// <param name="songID"></param>
        public void DeleteReferences(int songID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec<DataTable>("RemoveGenreReferencesBySong " + songID);
            }
        }

        public void RemoveReference(int songID, int genreID)
        {
            using(MusicContext context = new MusicContext())
            {
                context.Exec("Exec DeleteGenreToSong " + songID + ", " + genreID);
            }
        }
        #endregion
    }
}
