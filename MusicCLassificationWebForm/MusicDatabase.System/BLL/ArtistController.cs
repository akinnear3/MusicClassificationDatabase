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
    public class ArtistController
    {
        #region Create
        public void AddArtist(string name)
        {
            name = name.Replace(';', ' ');
            name = name.Replace('\'', ' ');//removes '
            name = name.Replace('"', ' ');//removes "
            name = name.Replace(" ", "__s_pa_ce__");//placeholder for spaces
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec AddArtist " + name);
            }
        }
        #endregion

        #region Read (select)
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable fetchAllArtists()
        {
            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("fetchArtists");
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable searchArtists(string partialName)
        {
            partialName = partialName.Replace(';', ' ');
            partialName = partialName.Replace('"', ' ');
            partialName = partialName.Replace('\'', ' ');

            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("Exec searchArtists " + partialName);
            }
        }
        #endregion

        #region Update
        #endregion

        #region Delete
        public void DeleteArtist(int ArtistID)
        {
            using(MusicContext context = new MusicContext())
            {
                context.Exec("Exec DeleteArtist " + ArtistID);
            }
        }
        #endregion

    }
}
