package dom;

import java.io.*;
import org.w3c.dom.*;  
import javax.xml.parsers.*; 

public class Iexp {

	public static void main(String[] args) throws Exception {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance(); 
		  dbf.setCoalescing(false);
		  dbf.setIgnoringElementContentWhitespace(true); 
		  DocumentBuilder db = dbf.newDocumentBuilder(); 
		  Document document = db.parse(new File("expMath.xml")); 
		  Element exps = (Element) document.getDocumentElement().getFirstChild().getNextSibling(); 
		  Element exp = document.createElement("exp") ; 
		  exp.setAttribute("nom", "exp4"); 
		  Element op1 = document.createElement("op"); 
		  op1.setAttribute("symbole", "mult");
		  Element var1 = document.createElement("var"); 
		  var1.setAttribute("nom", "A"); 
		  Element op2 = (Element) op1.cloneNode(true); 
		  Element var2 = (Element) var1.cloneNode(true);
		  Element var3 = (Element) var1.cloneNode(true);
		  op1.appendChild(op2); op1.appendChild(var3);  
		  op2.appendChild(var1); op2.appendChild(var2);   
		  exp.appendChild(op1); 
		  exps.appendChild(exp);
		  XMLTOOLS1.ecrireXML(document, "expbis.xml", "expMath.dtd");  
	}

}
