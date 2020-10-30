# Average-Precipatation
You are asked to write a code that computes daily average precipitation over the basin for which the boundaries are specified in the file .BDY in the folder. Precipitation data for January 1951 are in the NETCDF4 prcp-195101-grd-scaled.nc
Steps to follow:
	you have the basin boundaries and the gridded precipitation values (meaning that, for each day you will have a precipitation value for each cell)
	overlap the basin to the grid in order to identify the cells (or partial cells) that belong to the basin
	make a weighted average of the daily precipitation for this basin, being the weight the portion of cell that falls within the basin boundaries
The daily average precipitation over the basin will be computed as:
p_avg=  (∑_(i,j)^(n_rows,n_cols)▒〖k_ij p_ij 〗)/(∑_(i,j)^(n_rows,n_cols)▒k_ij )
with k_ij the percentage of the cell ij belonging to the basin and p_ij the daily precipitation value in cell ij
