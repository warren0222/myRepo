from PyPDF2 import PdfFileReader, PdfFileWriter

def splitPdf(readFile, outFile, start_page, end_page):
    pdfFileWriter = PdfFileWriter()
    # 获取 PdfFileReader 对象
    pdfFileReader = PdfFileReader(readFile)  # 或者这个方式：pdfFileReader = PdfFileReader(open(readFile, 'rb'))
    # 文档总页数
    numPages = pdfFileReader.getNumPages()
    start_page -= 1 #把人类感官的页数（1开始）改成计算机认的页数（0开始）
    end_page -= 1
    for index in range(start_page, end_page):
        pageObj = pdfFileReader.getPage(index)
        pdfFileWriter.addPage(pageObj)
    # 添加完每页，再一起保存至文件中
    pdfFileWriter.write(open(outFile, 'wb'))

readFile = 'f:/docker_practice.pdf'
outFile = 'f:/aaa.pdf'
splitPdf(readFile, outFile, start_page=2, end_page=10)
