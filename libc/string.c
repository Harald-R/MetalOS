// Compute the length of the string str
int strlen(unsigned char *str)
{
	int nr = 0;
	
	while(*str++)
	{
		nr++;
	}

	return nr;
}
