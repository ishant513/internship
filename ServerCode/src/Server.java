import java.net.*;
import java.io.*;  
public class Server {  
	
	public static void main(String args[]) throws Exception{  
		ServerSocket serversock = new ServerSocket(9000);
		
		System.out.println("Waiting for connection :|");
		Socket sock = serversock.accept();
		System.out.println("Connected :)");
		DataInputStream din = new DataInputStream(sock.getInputStream());
		BufferedReader d = new BufferedReader(new InputStreamReader(din));
		DataOutputStream dout = new DataOutputStream(sock.getOutputStream());
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String lineread = null;
		String str = "";
		boolean sent = true;
		while(sent){
			System.out.println("in loop");
			lineread = d.readLine();
			System.out.println("client says: " + lineread);
			str = br.readLine();
			dout.writeUTF(str);
			dout.flush();
		}
		d.close();
		din.close();
		sock.close();
		serversock.close();
	}
}