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
    public class RatingController
    {
        #region Create
        public void AddRating(string rating)
        {
            rating = rating.Replace(';', ' ');
            rating = rating.Replace('\'', ' ');//removes '
            rating = rating.Replace('"', ' ');//removes "
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec AddRating '" + rating + "'");
            }
        }
        #endregion
        #region Read (select)
        /// <summary>
        /// get all of the ratings
        /// </summary>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable GetAllRatings()
        {
            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("fetchRatings");
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable searchRatings(string partialRating)
        {
            partialRating = partialRating.Replace(';', ' ');
            partialRating = partialRating.Replace('"', ' ');
            partialRating = partialRating.Replace('\'', ' ');
            if (string.IsNullOrEmpty(partialRating.Trim()))
            {
                partialRating = "__No_th_ing_";
            }

            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("Exec searchRatings '" + partialRating + "'");
            }
        }
        #endregion

        #region Update
        #endregion

        #region Delete
        public void DeleteRating(int RatingID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec DeleteRating " + RatingID);
            }
        }
        #endregion
    }
}
