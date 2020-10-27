import requests
import sys

url = sys.argv[1]
outfile = sys.argv[2]
def download_file(url, outfile):
    local_filename = outfile
    # NOTE the stream=True parameter below
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192): 
                # If you have chunk encoded response uncomment if
                # and set chunk_size parameter to None.
                #if chunk: 
                f.write(chunk)
    return local_filename


#file = download_file("https://app.box.com/shared/static/obsdop264a4jxdqws2cqn9ubaxrqsgjl.zip")
file = download_file(url, outfile)
print (file)

