using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;

using MusicDatabase.System.DAL;
using MusicDatabase.System.Data;

namespace MusicDatabase.System.BLL
{
    [DataObject]
    public class SongController
    {
        //these are the methods used to create more songs
        #region Create
        public int CreateSong(string name, int filetype)
        {
            name = name.Replace(';', ' ');
            name = name.Replace('"', ' ');//replaces "
            name = name.Replace('\'', ' ');//replaces '
            name = name.Replace(" ", "____");//a temporary replacement for spaces because it has dificulty recognizing spaces
            using(MusicContext context = new MusicContext())
            {
                DataTable t = context.Exec<DataTable>("Exec createSong " + name + ", " + filetype);
                return t.Rows[0].Field<int>("SongID");
            }

        }
        #endregion
        
        //these are the methods to get information about songs
        #region Read
        public DataTable fetchAllSongs()
        {
            using(MusicContext context = new MusicContext())
            {
                DataTable t = context.Exec<DataTable>("Exec fetchAllSongs");

                //add the filetype descriptions
                t.Columns.Add("Filetype");
                int[] fileID = new int[t.Rows.Count];
                
                //add genres if any
                t.Columns.Add("Genres");

                //add Ratings if any
                t.Columns.Add("Ratings");

                //add artists if any
                t.Columns.Add("Artists");

                //for each song
                DataTable t2;
                string columInfo;
                DataRow[] rowInfo;
                for (int i = 0; i < t.Rows.Count; i++)
                {
                    #region add genres
                    //gather all the genres into a string 
                    t2 = context.Exec<DataTable>("Exec fetchGenreBySongID " + t.Rows[i].Field<int>("SongID"));
                    columInfo = "";

                    for (int ii = 0; ii < t2.Rows.Count; ii++)
                    {
                        columInfo += ", " + t2.Rows[ii].Field<string>("Genre");
                    }

                    //remove ", " from the start and the end
                    columInfo = columInfo.TrimStart(new char[] { ',', ' ' });
                    columInfo = columInfo.TrimEnd(new char[] { ',', ' ' });

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Genres"] = columInfo;
                    #endregion

                    #region add ratings
                    //gather all the ratings into a string 
                    t2 = context.Exec<DataTable>("Exec fetchRatingBySongID " + t.Rows[i].Field<int>("SongID"));
                    columInfo = "";
                    for (int ii = 0; ii < t2.Rows.Count; ii++)
                    {
                        columInfo += ", " + t2.Rows[ii].Field<string>("Rating");
                    }

                    //remove ", " from the start and the end
                    columInfo = columInfo.TrimStart(new char[] { ',', ' ' });
                    columInfo = columInfo.TrimEnd(new char[] { ',', ' ' });

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Ratings"] = columInfo;
                    #endregion

                    #region add artists
                    //gather all the ratings into a string 
                    t2 = context.Exec<DataTable>("Exec fetchArtistsBySongID " + t.Rows[i].Field<int>("SongID"));
                    columInfo = "";
                    for (int ii = 0; ii < t2.Rows.Count; ii++)
                    {
                        columInfo += ", " + t2.Rows[ii].Field<string>("Name");
                    }

                    //remove ", " from the start and the end
                    columInfo = columInfo.TrimStart(new char[] { ',', ' ' });
                    columInfo = columInfo.TrimEnd(new char[] { ',', ' ' });

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Artists"] = columInfo;
                    #endregion

                    #region add filetype Descriptions
                    //gather all the genres into a string 
                    t2 = context.Exec<DataTable>("Exec fetchFiletypeDescription " + t.Rows[i].Field<int>("FiletypeID"));
                    columInfo = t2.Rows[0].Field<string>("filetype");

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Filetype"] = columInfo;
                    #endregion
                }

                
                return t;
            }
        }
        public DataTable fetchSong(int songID)
        {
            using(MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("Exec fetchSongBySongID " + songID.ToString());
            }
        }
        
        public DataTable fetchSongs_WithRestrictions(string partialname, int GenreID, int FiletypeID, int RatingID, int ArtistID)
        {
            partialname = partialname.Replace(';', ' ');
            partialname = partialname.Replace('"', ' ');//replace "
            partialname = partialname.Replace('\'', ' ');//replace '

            using (MusicContext context = new MusicContext())
            {
                DataTable t = context.Exec<DataTable>("Exec fetchSongsByAll " + partialname + " , " + ArtistID + ", " + GenreID + ", " + RatingID + ", " + FiletypeID);
                
                //add the filetype descriptions
                t.Columns.Add("Filetype");
                int[] fileID = new int[t.Rows.Count];

                //add genres if any
                t.Columns.Add("Genres");

                //add Ratings if any
                t.Columns.Add("Ratings");

                //add artists if any
                t.Columns.Add("Artists");

                //for each song
                DataTable t2;
                string columInfo;
                DataRow[] rowInfo;
                for (int i = 0; i < t.Rows.Count; i++)
                {
                    #region add genres
                    //gather all the genres into a string 
                    t2 = context.Exec<DataTable>("Exec fetchGenreBySongID " + t.Rows[i].Field<int>("SongID"));
                    columInfo = "";

                    for (int ii = 0; ii < t2.Rows.Count; ii++)
                    {
                        columInfo += ", " + t2.Rows[ii].Field<string>("Genre");
                    }

                    //remove ", " from the start and the end
                    columInfo = columInfo.TrimStart(new char[] { ',', ' ' });
                    columInfo = columInfo.TrimEnd(new char[] { ',', ' ' });

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Genres"] = columInfo;
                    #endregion

                    #region add ratings
                    //gather all the ratings into a string 
                    t2 = context.Exec<DataTable>("Exec fetchRatingBySongID " + t.Rows[i].Field<int>("SongID"));
                    columInfo = "";
                    for (int ii = 0; ii < t2.Rows.Count; ii++)
                    {
                        columInfo += ", " + t2.Rows[ii].Field<string>("Rating");
                    }

                    //remove ", " from the start and the end
                    columInfo = columInfo.TrimStart(new char[] { ',', ' ' });
                    columInfo = columInfo.TrimEnd(new char[] { ',', ' ' });

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Ratings"] = columInfo;
                    #endregion

                    #region add artists
                    //gather all the ratings into a string 
                    t2 = context.Exec<DataTable>("Exec fetchArtistsBySongID " + t.Rows[i].Field<int>("SongID"));
                    columInfo = "";
                    for (int ii = 0; ii < t2.Rows.Count; ii++)
                    {
                        columInfo += ", " + t2.Rows[ii].Field<string>("Name");
                    }

                    //remove ", " from the start and the end
                    columInfo = columInfo.TrimStart(new char[] { ',', ' ' });
                    columInfo = columInfo.TrimEnd(new char[] { ',', ' ' });

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Artists"] = columInfo;
                    #endregion

                    #region add filetype Descriptions
                    //gather all the genres into a string 
                    t2 = context.Exec<DataTable>("Exec fetchFiletypeDescription " + t.Rows[i].Field<int>("FiletypeID"));
                    columInfo = t2.Rows[0].Field<string>("filetype");

                    //insert the data
                    rowInfo = t.Select();
                    rowInfo[i]["Filetype"] = columInfo;
                    #endregion

                }

                return t;
            }
        }
        #endregion

        //these are the methods to update a song
        #region Update
        public DataTable UpdateSong(int SongID, string name, int filetypeID)
        {
            name = name.Replace(';', ' ');
            name = name.Replace('"', ' ');//replaces "
            name = name.Replace('\'', ' ');//replaces '
            name = name.Replace(" ", "____");//a temporary replacement for spaces because it has dificulty recognizing spaces
            using(MusicContext context = new MusicContext())
            {
                return context.Exec<DataTable>("Exec updateSong " + SongID + ", " + name + ", " + filetypeID);
            }

        }
        #endregion

        //these are the methods to delete a song
        #region Delete
        public void DeleteSong(int songID)
        {
            ArtistToSongController atos = new ArtistToSongController();
            atos.DeleteReferences(songID);
            GenreToSongController gtos = new GenreToSongController();
            gtos.DeleteReferences(songID);
            RatingToSongController rtos = new RatingToSongController();
            rtos.DeleteReferences(songID);

            using (MusicContext context = new MusicContext())
            {
                context.Exec("Exec deleteSong " + songID);
            }
        }
        #endregion
    }
}
