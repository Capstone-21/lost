package com.LFService;
import java.util.*;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Use this as a framework to collect custom test values and record the results
public class LFService extends HttpServlet{
	@Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) 
        throws IOException{
            resp.setContentType("text/plain");


            //recieve data from front end
		    String dateString = req.getParameter("datetime");
            //parse datetime for DBMS

            String description = req.getParameter("description");
            //ready to send to DBMS

            String tag1 = req.getParameter("tag1");
            String tag2 = req.getParameter("tag2");
            String tag3 = req.getParameter("tag3");
            String tag4 = req.getParameter("tag4");
            String tag5 = req.getParameter("tag5");
            //ready to send to DBMS



            //send results
            resp.getWriter().println("Data Recieved!");
    }
}