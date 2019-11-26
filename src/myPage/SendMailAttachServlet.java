package myPage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/SendMailAttachServlet")
@MultipartConfig(   fileSizeThreshold = 1024 * 1024 * 2,
                    maxFileSize = 1024 * 1024 * 50,         // 50MB
                    maxRequestSize = 1024 * 1024 * 50)      // 50MB
public class SendMailAttachServlet extends HttpServlet {
    private String host;
    private String port;
    private String user;
    private String pass;

    public void init() {
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        List<File> uploadedFiles = saveUploadedFiles(request);
        request.setCharacterEncoding("UTF-8");
        String recipient = "projektgracja2019@gmail.com";
        String subject = "[M - CV] Nowe zgłoszenie o pracę od: " + request.getParameter("imie-nazwisko") + ".";
        String content = "<head>" +
                "  <meta charset=\"UTF-8\">" +
                "</head>" +  "Imię i nazwisko: " + request.getParameter("imie-nazwisko") + "<br/>" +
        "Data urodzenia: " + request.getParameter("data-urodzenia") + "<br/>" +
        "E-Mail: " + request.getParameter("e-mail") + "<br/>" +
        "Telefon kontaktowy: " + request.getParameter("telefon") + "<br/>" +
        "Adres: "  + request.getParameter("ulica") + " " +  request.getParameter("Numer-domu") + "<br/>" +
                     request.getParameter("kod-pocztowy") + " " +  request.getParameter("miejscowosc");
        String resultMessage = "";
        try {
            EmailUtility.sendEmailWithAttachment(host, port, user, pass,
                    recipient, subject, content, uploadedFiles);
            resultMessage = "The e-mail was sent successfully";
        } catch (Exception ex) {
            ex.printStackTrace();
            resultMessage = "There were an error: " + ex.getMessage();
        } finally {
            deleteUploadFiles(uploadedFiles);
            request.setAttribute("message", resultMessage);
            getServletContext().getRequestDispatcher("/wynik-cv.jsp").forward(
                    request, response);
        }
    }

    private List<File> saveUploadedFiles(HttpServletRequest request)
            throws IllegalStateException, IOException, ServletException {
        List<File> listFiles = new ArrayList<File>();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        Collection<Part> multiparts = request.getParts();
        if (multiparts.size() > 0) {
            for (Part part : request.getParts()) {
                String fileName = extractFileName(part);
                if (fileName == null || fileName.equals("")) {
                    continue;
                }

                File saveFile = new File(fileName);
                System.out.println("saveFile: " + saveFile.getAbsolutePath());
                FileOutputStream outputStream = new FileOutputStream(saveFile);
                InputStream inputStream = part.getInputStream();
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.close();
                inputStream.close();
                listFiles.add(saveFile);
            }
        }
        return listFiles;
    }
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
    private void deleteUploadFiles(List<File> listFiles) {
        if (listFiles != null && listFiles.size() > 0) {
            for (File aFile : listFiles) {
                aFile.delete();
            }
        }
    }
}
