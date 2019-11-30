
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;

import db.DatabaseException;
import db.SessionsManager;
import models.Course;
import models.Location;
import models.Session;
import models.Status;
import models.User;
import util.ImmutableList;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MainPage
 */
@WebServlet("/MainPage")
public class MainPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String CREDENTIALS_STRING = "jdbc:mysql://google/cpfinder?cloudSqlInstance=cpfinder-259622:us-west2:db1&socke"
		+ "tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root" +
	"&password=uscCs201!";
	static Connection connection = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainPage() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	ArrayList<Course> courses = new ArrayList<Course>();
    	ArrayList<User> users = new ArrayList<User>();
    	ArrayList<Location> locations = new ArrayList<Location>();
    	ArrayList<Status> statuses = new ArrayList<Status>();
    	String sessionsString = "";
    	Gson gson = new Gson();
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		connection = DriverManager.getConnection(CREDENTIALS_STRING);
        	SessionsManager sm = new SessionsManager(connection);
        	ImmutableList<Session> activeSessions = sm.getSessions(true);
        	sessionsString = gson.toJson(activeSessions);
        	for (int i = 0; i < activeSessions.size(); i++) {
        		Course course = activeSessions.get(i).getCourse();
        		User user = activeSessions.get(i).getUser();
        		Location location = activeSessions.get(i).getLocation();
        		Status status = activeSessions.get(i).getStatus();
        		courses.add(course);
        		users.add(user);
        		locations.add(location);
        		statuses.add(status);
        	}
    	} catch (SQLException | ClassNotFoundException | DatabaseException sqle) {
    		System.out.println(sqle.getMessage());
    	} 
		request.setAttribute("sessions", sessionsString);
		session.setAttribute("sessions", sessionsString);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/MainPage.jsp");
		dispatch.forward(request, response);
    	
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
