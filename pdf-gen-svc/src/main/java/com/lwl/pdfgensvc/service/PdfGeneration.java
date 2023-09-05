package com.lwl.pdfgensvc.service;

import org.apache.fop.apps.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.xml.sax.SAXException;

import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;

@Component
public class PdfGeneration {
  public void convertToPDF() throws IOException, SAXException, TransformerException {
    String fileName = "invoice";
     File xsltFile = new File(PdfGeneration.class.getResource("/"+fileName+".xsl").getFile());
     StreamSource xmlSource = new StreamSource(PdfGeneration.class.getResourceAsStream("/"+fileName+".xml"));
    File file = new ClassPathResource("custom_font.xml").getFile();
    System.out.println(file.getAbsolutePath());
    // create an instance of fop factory
    FopFactory fopFactory = FopFactory.newInstance(file);
    // a user agent is needed for transformation
    FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
    // Setup output
    OutputStream out;

    out = new java.io.FileOutputStream(fileName+".pdf");

    try {
      // Construct fop with desired output format
      Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);
      fopFactory.newFop("application/pdf", fopFactory.newFOUserAgent(), out);

      // Setup XSLT
      TransformerFactory factory = TransformerFactory.newInstance();
      Transformer transformer = factory.newTransformer(new StreamSource(xsltFile));

      // Resulting SAX events (the generated FO) must be piped through to FOP
      Result res = new SAXResult(fop.getDefaultHandler());

      // Start XSLT transformation and FOP processing
      // That's where the XML is first transformed to XSL-FO and then
      // PDF is created
      transformer.transform(xmlSource, res);

    } finally {
      out.close();
    }
  }

}