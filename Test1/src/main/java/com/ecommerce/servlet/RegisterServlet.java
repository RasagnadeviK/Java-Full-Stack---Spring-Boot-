package com.ecommerce.servlet;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.*;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import com.ecommerce.dao.UserDaoImp;
import com.ecommerce.pojo.User;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

import javax.mail.MessagingException;
/**
 * Servlet implementation class RegisterServlet
 */
@SpringBootApplication
@WebServlet("/RegisterServlet")
@MultipartConfig
@Component
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
	public RegisterServlet() {
	    super();
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		HttpSession session=request.getSession();
		String username=request.getParameter("username");
		String useremail=request.getParameter("useremail");
		String userpassword=request.getParameter("userpassword");
		String userphone=request.getParameter("userphone");
		String useraddress=request.getParameter("useraddress");
		Part part=request.getPart("productPic");
		String fileName=part.getSubmittedFileName();
		
		String uploadPath="/Test1/src/main/webapp/userProfilePic/"+fileName;
		
		try
		{
		FileOutputStream fos=new FileOutputStream(uploadPath);
		InputStream is=part.getInputStream();
		
		byte[] data=new byte[is.available()];
		is.read(data);
		fos.write(data);
		fos.close();
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}

		User user=new User(username,useremail,userpassword,userphone,fileName,useraddress,"normal");
	    UserDaoImp u=new UserDaoImp();
	    boolean isAlreadyUser=u.isAlreadyUser(useremail);
	    if(isAlreadyUser==true)
	    {
	    	session.setAttribute("message","User is Already registered with this Email..!");
	        response.sendRedirect("register.jsp");
	    }
	    
	    else
	    {
	    	boolean flag=u.addUser(user);
			
		    if(flag==true)
		    {
		    	
		    	//System.out.println("SMS sent successfully: " + message.getSid());
		    	//} catch (Exception e) {
		    	   // e.printStackTrace();
		    	//}
		    	    sendThankYouEmail(useremail);
		            session.setAttribute("message", "Registration Successful. Thank you!");
		            response.sendRedirect("register.jsp");
		        } 
		    else
		    {
		    	session.setAttribute("message","Registration Failed..!!!");
		    	response.sendRedirect("register.jsp");
		    }
	    }    	
	}
	
	private void sendThankYouEmail(String userEmail) {
		
		final String host = "smtp.elasticemail.com";
	    final int smtpport = 2525; // Change this to your SMTP port
	    final String username = "2100090151csit@gmail.com";
	    final String password = "E39F562B194DD1B9ED23628C0BCA369293E1";


        try (Socket socket = new Socket(host, smtpport);
                BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()))) 
        {

               String line = reader.readLine();
               System.out.println(line);

               // Sending EHLO command
               writer.write("EHLO elasticemail.com\r\n");
               writer.flush();
               line = reader.readLine();
               System.out.println(line);

               // Sending STARTTLS command (if required by your server)
               // Example: writer.write("STARTTLS\r\n");
               // Example: writer.flush();
               // Example: line = reader.readLine();
               // Example: System.out.println(line);

               // Authenticating with username and password (if required by your server)
               // Example: writer.write("AUTH LOGIN\r\n");
               // Example: writer.flush();
               // Example: line = reader.readLine();
               // Example: System.out.println(line);
               // Example: writer.write(Base64.getEncoder().encodeToString(username.getBytes(StandardCharsets.UTF_8)) + "\r\n");
               // Example: writer.flush();
               // Example: line = reader.readLine();
               // Example: System.out.println(line);
               // Example: writer.write(Base64.getEncoder().encodeToString(password.getBytes(StandardCharsets.UTF_8)) + "\r\n");
               // Example: writer.flush();
               // Example: line = reader.readLine();
               // Example: System.out.println(line);

               // Sending MAIL FROM and RCPT TO commands
               writer.write("MAIL FROM: <" + username + ">\r\n");
               writer.flush();
               line = reader.readLine();
               System.out.println(line);
               writer.write("RCPT TO: <" + userEmail + ">\r\n");
               writer.flush();
               line = reader.readLine();
               System.out.println(line);

               // Sending DATA command to start the email message
               writer.write("DATA\r\n");
               writer.flush();
               line = reader.readLine();
               System.out.println(line);

               // Constructing and sending the email content
               writer.write("From: " + username + "\r\n");
               writer.write("To: " + userEmail + "\r\n");
               writer.write("Subject: Thank you for Registering!\r\n");
               writer.write("\r\n");
               writer.write("Dear User,\r\n");
               writer.write("\r\n");
               writer.write("Thank you for registering on our platform. We appreciate your registration!\r\n");
               writer.write("\r\n");
               writer.write("Sincerely,\r\n");
               writer.write("The Team\r\n");
               writer.write(".\r\n");
               writer.flush();
               line = reader.readLine();
               System.out.println(line);

               // Sending QUIT command to close the connection
               writer.write("QUIT\r\n");
               writer.flush();
               line = reader.readLine();
               System.out.println(line);

           } catch (IOException e) {
               e.printStackTrace();
           }
       
    }


}

