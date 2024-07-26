package controller.post;

import entity.Post;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import repository.impl.PostRepositoryImpl;

@WebServlet(name = "PostServlet", urlPatterns = {"/post", "/post/add", "/post/update", "/post/delete"})
public class PostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();

        switch (ACTION) {
            case "/post/add" -> {
                addPost(request, response);
            }
            case "/post" -> {
                showAllPosts(request, response);
            }
            case "/post/delete" -> {
                deletePost(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();

        switch (ACTION) {
            case "/post/update" -> {
                updatePost(request, response);
            }
        }
    }
    
    private void showAllPosts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostRepositoryImpl pri = new PostRepositoryImpl();
        List<Post> listP= pri.findAll();
        request.setAttribute("posts", listP);
        request.getRequestDispatcher("/main/post.jsp").forward(request, response);
    }
    
    private void addPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/main/login.jsp"); // Redirect to login if user is not logged in
            return;
        }
        

        String title = request.getParameter("titleData");
        String content = request.getParameter("editorData");

        if (title != null && !title.isEmpty() && content != null && !content.isEmpty()) {
            PostRepositoryImpl pri = PostRepositoryImpl.getInstance();
            
            Post post = new Post(null, title, content, u , null);
            boolean success = pri.add(post);
            
            if (success) {
                request.setAttribute("title", title);
                request.setAttribute("content", content);
                request.getRequestDispatcher("/post").forward(request, response);
            } else {
                // Handle the case where adding the post to the database failed
                request.setAttribute("error", "Failed to add post to the database.");
                request.getRequestDispatcher("/main/newpost.jsp").forward(request, response);
            }
        } else {
            // Handle the case where title or content is empty
            request.setAttribute("error", "Title and content must not be empty.");
            request.getRequestDispatcher("/main/newpost.jsp").forward(request, response);
        }
    }
    
    private void deletePost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PostRepositoryImpl pri = PostRepositoryImpl.getInstance();
        Long post_id = Long.valueOf(request.getParameter("id"));
            boolean isDeleted = pri.deleteById(post_id);
        
        if (isDeleted) {
            response.sendRedirect("/post?deleted=yes");
        } else {
            response.sendRedirect("/post?deleted=no");
        }
    }
    
    private void updatePost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long postId = Long.valueOf(request.getParameter("id"));
        String postTitle = String.valueOf(request.getParameter("title"));
        String postContent = String.valueOf(request.getParameter("content"));
        if(postTitle!=null && !postTitle.isEmpty() && !postTitle.isBlank() && postContent !=null && !postContent.isEmpty() && !postContent.isBlank()){
        
        Post post = new Post(postId,postTitle,postContent,null,null);
        PostRepositoryImpl pri = new PostRepositoryImpl();
        Post isUpdated = pri.save(post);
        if (isUpdated != null) {
            response.sendRedirect("/post?updated=yes");
        } else {
            response.sendRedirect("/post?updated=no");
        }
        }else {
            response.sendRedirect("/post?updated=no");
        }
    }
}
