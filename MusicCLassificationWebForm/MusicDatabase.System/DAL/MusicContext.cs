using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;
using System.Data;
using MusicDatabase.System.Data;

namespace MusicDatabase.System.DAL
{
    internal class MusicContext : IDisposable
    {
        /// <summary>
        /// this is the connection to the database
        /// </summary>
        internal SqlConnection db;

        /// <summary>
        /// this is an outlet to read and capture data from the database.
        /// store the informaton will the method "fill".
        /// You can fill a table or a DataSet
        /// </summary>
        SqlDataAdapter da;

        /// <summary>
        /// this string contains the connection information required to access the database
        /// </summary>
        private string _connectionString = "Data Source=.;Initial Catalog=MusicClassificationDatabase;Integrated Security=True";

        /// <summary>
        /// default instantiation of Context.
        /// Creates and oppens a connection.
        /// </summary>
        public MusicContext()
        {
            OpenConection();
        }

        /// <summary>
        /// releases all connections by disposing of them;
        /// </summary>
        public void Dispose()
        {
            db.Dispose();
            da.Dispose();
        }

        /// <summary>
        /// this creates a new connection to the database
        /// </summary>
        public void OpenConection()
        {
            db = new SqlConnection(_connectionString);
            db.Open();
        }

        /// <summary>
        /// querry the database to get back information of the provided type
        /// </summary>
        /// <param name="querry">the stored procedure name and parameters of the querry</param>
        /// <returns></returns>
        public ReturnType Exec<ReturnType>(string querry)
        {
            querry = querry.Trim(';', '"');
            da = new SqlDataAdapter(querry, db);
            DataTable t = new DataTable();
            da.Fill(t);
            return (ReturnType) Convert.ChangeType(t, typeof(ReturnType));
        }

        /// <summary>
        /// querry the database to set, update or delete information. 
        /// Nothing is returned from this querry
        /// </summary>
        /// <param name="querry">the stored procedure name and parameters of the querry</param>
        public void Exec(string querry)
        {
            querry = querry.Replace(';', ' ');
            querry = querry.Replace('"', ' ');//want to replace "
            da = new SqlDataAdapter(querry, db);
            DataTable t = new DataTable();
            da.Fill(t);
        }

        //public DataSet GetSongs_AsDataSet()
        //{
        //    DataSet info = new DataSet();
        //    da = new SqlDataAdapter("fetchAllSongs", db);
        //    da.Fill(info);

        //    return info;
        //}

        //public List<MusicDatabase_Song> GetSongs()
        //{
        //    DataTable dt = new DataTable("Songs");
        //    da = new SqlDataAdapter("fetchAllSongs", db);
        //    da.Fill(dt);

        //    List<MusicDatabase_Song> songs = new List<MusicDatabase_Song>();
        //    for(int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        songs.Add(new MusicDatabase_Song());
        //        songs[i].SongID = dt.Rows[i].Field<int>("SongID");
        //        songs[i].SongName = dt.Rows[i].Field<string>("SongName");
        //        songs[i].FiletypeID = dt.Rows[i].Field<int>("FiletypeID");
        //    }
        //    return songs;
        //}



        //public IReturn GetInfo<IReturn>(string querryToExecute)
        //{
        //    IReturn info;

        //    info = new  MusicDatabase_Artist();

        //    return info;
        //}



    }


}
