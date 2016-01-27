package dom;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import org.w3c.dom.Document;

public class XMLTOOLS1 {

	public static void ecrireXML(Document document, String nameFile, String DTDFile) {
		  try{
		    TransformerFactory tfabrique = TransformerFactory.newInstance();
		    Transformer transformeur = tfabrique.newTransformer();
		    Properties proprietes = new Properties();
		    proprietes.put("method", "xml");
		    proprietes.put("encoding", "UTF-8"); 
		    proprietes.put("indent", "yes");
		    if (DTDFile != null)
		    proprietes.put(OutputKeys.DOCTYPE_SYSTEM,DTDFile);
		    transformeur.setOutputProperties(proprietes);
		    Source entree = new DOMSource(document);
		    File oFic = new File(nameFile);
		    FileOutputStream fos = new FileOutputStream(oFic);

		    if(fos != null) {
		      Result sortie = new StreamResult(fos);
		      transformeur.transform(entree, sortie);
		    }

		    fos.flush();
		    fos.close();
		  }
		  catch (FileNotFoundException e) {
		    e.printStackTrace();
		  }
		  catch (FactoryConfigurationError e) {
		    //erreur de configuration de fabrique
		    e.printStackTrace();
		  }
		  catch (TransformerException e) {
		    //erreur lors de la transformation
		    e.printStackTrace();
		  }
		  catch (IOException e) {
		    e.printStackTrace();
		  }
		}
		         
	         public static void xslTranform(String xslNameFile, String xmlNameFile, String outNameFile){ 
	        	  try{ TransformerFactory factory = TransformerFactory.newInstance(); 
	     		  Transformer transfXSLT = factory.newTransformer(new StreamSource(xslNameFile));
	     		  Transformer transXML = factory.newTransformer();
	     		  DOMResult out = new DOMResult();   
	     		  transfXSLT.transform(new StreamSource(xmlNameFile), out);  
	     		  transXML.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
	     		  transXML.transform(new DOMSource(out.getNode()), new StreamResult(outNameFile));
	        	  } 
	        	  catch(TransformerException e){System.out.println("Transformer Exception:"+e);}
	         }
	   }