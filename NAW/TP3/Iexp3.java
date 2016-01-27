package dom;

import java.io.*;
import org.w3c.dom.*;  
import javax.xml.parsers.*; 

public class Iexp3 {

	public static void main(String[] args) throws Exception {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance(); 
		  dbf.setCoalescing(false);
		  dbf.setIgnoringElementContentWhitespace(true); 
		  DocumentBuilder db = dbf.newDocumentBuilder(); 
		  Document document = db.parse(new File("expbis.xml")); 
		  Element constantes = (Element) document.getDocumentElement().getFirstChild();
		  NodeList consts = constantes.getChildNodes();
		  
		  for (int i = 0; i < consts.getLength(); i++) {
			  Element myConst = ((Element)consts.item(i));
			  String name = myConst.getAttribute("nom");
			  if (name.equals("A")) {
				  myConst.setAttribute("valeur", "5");
			  } else if (name.equals("B")) {
				  myConst.setAttribute("valeur", "10");
			  } else if (name.equals("C")) {
				  myConst.setAttribute("valeur", "15");
			  }
		  } 
		  XMLTOOLS1.ecrireXML(document, "expbisbis.xml", "expMath.dtd");  
	}

}
