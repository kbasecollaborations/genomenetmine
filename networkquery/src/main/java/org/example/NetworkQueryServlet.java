// Reflecting the directory structure where the file lives
package org.example;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class NetworkQueryServlet extends HttpServlet {


   public  void doPost(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException
    {

        PrintWriter writer = response.getWriter();
        try {

            String genelist = request.getParameter("genelist");
            String keywords = request.getParameter("keywords");
            String knet  = request.getParameter("knet");

            String query_url = "http://localhost:5000/ws/" + knet + "/genome?" + "list=" + genelist + "&" + "keywords=" + keywords;
            System.out.println(query_url);

            URL url = new URL(query_url);//your url i.e fetch data from .
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP Error code : "
                        + conn.getResponseCode());
            }
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(in);
            String output;
            

            while ((output = br.readLine()) != null) {
                writer.print(output);
             }
            conn.disconnect();

        } catch (Exception e) {
            writer.print("Exception in NetClientGet:- " + e);
        }
 
}   
}
