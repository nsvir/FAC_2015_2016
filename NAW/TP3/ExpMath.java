package dom;
import java.io.*;
import org.w3c.dom.*;  
import javax.xml.parsers.*; 

public class ExpMath {  
	  
	  public static double evaluate(Element e, Element rac){ 
		  if (e.getTagName().equals("op")) 
		  {   NodeList operandes = e.getChildNodes(); 
		      double v1 = evaluate((Element) operandes.item(0), rac); 
		      double v2 = evaluate((Element) operandes.item(1), rac); 
			  if (e.getAttribute("symbole").equals("plus"))  
				  return v1+ v2; 
			  if (e.getAttribute("symbole").equals("moins"))  
				  return v1- v2; 
			  if (e.getAttribute("symbole").equals("mult"))  
				  return v1* v2; 
			  if (e.getAttribute("symbole").equals("div"))  
				  return v1/v2; 
			  return 0;
		  }
			  
		  if  (e.getTagName().equals("var"))  
		  {  String n = e.getAttribute("nom"); 
		     NodeList consts = rac.getElementsByTagName("const"); 
		     for (int i=0; i<consts.getLength();i++)
		     { Element c = (Element) consts.item(i); 
		       String nc = c.getAttribute("nom"); 
		       if (nc.equals(n)) 
		           return  Integer.parseInt(c.getAttribute("valeur"));       
		     }  
		  } 
		  return 0;
	  }
  
	  public static void main(String[] args) throws Exception
	  {  
	  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance(); 
	  dbf.setCoalescing(false);
	  dbf.setIgnoringElementContentWhitespace(true); 
	  DocumentBuilder db = dbf.newDocumentBuilder(); 
	  Document document = db.parse(new File(args[0])); 
	  Element rac = document.getDocumentElement(); 
	  System.out.println(rac.getTagName());
	  NodeList lesEx = rac.getElementsByTagName("exp"); 
	  for (int i=0; i<lesEx.getLength(); i++) 
	  {     String n = ((Element)lesEx.item(i)).getAttribute("nom");
		    Element ex = (Element) lesEx.item(i).getFirstChild(); 
	        System.out.println(n+":="+evaluate(ex, rac));	        
	  }
	  }	
	}


