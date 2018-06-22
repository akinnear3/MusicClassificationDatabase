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
    public class GenreController
    {
        #region Create
        public void AddGenre(string genre)
        {
            genre = genre.Replace(';', ' ');
            genre = genre.Replace('\'', ' ');//removes '
            genre = genre.Replace('"', ' ');//removes "
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec AddGenre '" + genre + "'");
            }
        }
        #endregion

        #region Read (select)
        /// <summary>
        /// get all of the genres
        /// </summary>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable GetAllGenres()
        {
            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("fetchGenres");
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable searchGenres(string partialGenre)
        {
            partialGenre = partialGenre.Replace(';', ' ');
            partialGenre = partialGenre.Replace('"', ' ');
            partialGenre = partialGenre.Replace('\'', ' ');
            if (string.IsNullOrEmpty(partialGenre.Trim()))
            {
                partialGenre = "__No_th_ing_";
            }

            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("Exec searchGenres '" + partialGenre + "'");
            }
        }
        #endregion

        #region Update
        public void UpdateGenre(int genreID, string genre)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec UpdateGenre " + genreID + ", '" + genre + "'");
            }
        }
        #endregion

        #region Delete
        public void DeleteGenre(int genreID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec DeleteGenre " + genreID);
            }
        }
        #endregion

    }
}
