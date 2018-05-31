using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using MusicDatabase.System.DAL;
using System.Data.Sql;
using System.Data.SqlTypes;

namespace MusicDatabase.System.BLL
{
    [DataObject]
    public class FiletypeController
    {
        #region Create
        public void AddFiletype(string filetype)
        {
            filetype = filetype.Replace(';', ' ');
            filetype = filetype.Replace('\'', ' ');
            filetype = filetype.Replace('"', ' ');

            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec AddFiletype '" + filetype + "'");
            }
        }
        #endregion
        #region Read (select)
        /// <summary>
        /// get all of the filetypes
        /// </summary>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable GetFiletypes()
        {
            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("Exec fetchFiletypes");
            }
        }

        /// <summary>
        /// selects all filetypes that match the partial filetype name
        /// </summary>
        /// <param name="partialFiletype"></param>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataTable fetchFiletypesbyPartial(string partialFiletype)
        {
            partialFiletype = partialFiletype.Replace(';', ' ');
            partialFiletype = partialFiletype.Replace('\'', ' ');
            partialFiletype = partialFiletype.Replace('"', ' ');
            using (MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("Exec fetchFiletypeByPartial '" + partialFiletype + "'");
            }
        }
        #endregion

        #region Update
        #endregion

        #region Delete
        /// <summary>
        /// deletes the filetype by ID
        /// </summary>
        /// <param name="filetypeID"></param>
        public void DeleteFiletype(int filetypeID)
        {
            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec DeleteFiletype " + filetypeID);
            }
        }
        #endregion
    }
}
