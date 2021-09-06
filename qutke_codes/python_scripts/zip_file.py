import zipfile, os
# zipFile = zipfile.ZipFile(r'/Users/chentianbo/Desktop/202106月rscxctptNew.zip'), 'w')
zipfile.write(r'/Users/chentianbo/Desktop/202106月rscxctptNew', '/Users/chentianbo/Desktop/abc.zip', zipfile.ZIP_DEFLATED)
zipfile.close()