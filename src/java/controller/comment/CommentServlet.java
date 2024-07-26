package controller.comment;

import entity.Comment;
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
import repository.impl.CommentRepositoryImpl;
import repository.impl.PostRepositoryImpl;

@WebServlet(name = "CommentServlet", urlPatterns = {"/comment", "/comment/add", "/comment/update", "/comment/delete"})
public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();

        switch (ACTION) {
            case "/comment" -> {
                showAllComments(request, response);
            }
            case "/comment/delete" -> {
                deleteComment(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();

        switch (ACTION) {
            case "/comment/add" -> {
                addComment(request, response);
            }
            case "/comment/update" -> {
                updateComment(request, response);
            }
        }
    }

    private void showAllComments(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        CommentRepositoryImpl cri = new CommentRepositoryImpl();
        Long post_id = Long.valueOf(request.getParameter("post_id"));
        List<Comment> listC = cri.findAll(post_id);
        request.setAttribute("coms", listC);
        request.setAttribute("post_id", post_id);
        request.getRequestDispatcher("/main/comment.jsp").forward(request, response);
    }

    private void addComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/main/login.jsp"); // Redirect to login if user is not logged in
            return;
        }
        PostRepositoryImpl pri = new PostRepositoryImpl();
        CommentRepositoryImpl cri = new CommentRepositoryImpl();
        Long post_id = Long.valueOf(request.getParameter("post_id"));
        String content = request.getParameter("content");
        Post p = pri.findById(post_id);

        if (content != null && !content.isEmpty() && !content.isBlank()) {
            Comment cmt = new Comment(null, content, u, p, null);
            boolean success = cri.add(cmt);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/comment?post_id=" + post_id);
            } else {
                // Handle the case where adding the post to the database failed
                request.setAttribute("error", "Failed to add comment to the database.");
                response.sendRedirect(request.getContextPath() + "/comment?post_id=" + post_id);
            }
        } else {
            // Handle the case where title or content is empty
            request.setAttribute("error", "Your comment must not be empty.");
            response.sendRedirect(request.getContextPath() + "/comment?post_id=" + post_id);
        }
    }

    private void deleteComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        CommentRepositoryImpl pri = new CommentRepositoryImpl();
        Long cmt_id = Long.valueOf(request.getParameter("id"));
        Long post_id = pri.findById(cmt_id).getPost_id().getPost_id();
        boolean isDeleted = pri.deleteById(cmt_id);

        if (isDeleted) {
            response.sendRedirect("/comment?post_id=" + post_id + "&deleted=yes");
        } else {
            response.sendRedirect("/comment?post_id=" + post_id + "&deleted=no");
        }
    }

    private void updateComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long cmt_id = Long.valueOf(request.getParameter("id"));
        CommentRepositoryImpl cri = new CommentRepositoryImpl();
        Long post_id = cri.findById(cmt_id).getPost_id().getPost_id();
        String content = String.valueOf(request.getParameter("content"));
        if (content != null && !content.isEmpty() && !content.isBlank()) {
            Comment cmt = new Comment(cmt_id, content, null, null, null);
            Comment isUpdated = cri.save(cmt);
            if (isUpdated != null) {
                response.sendRedirect("/comment?post_id=" + post_id + "&updated=yes");
            } else {
                response.sendRedirect("/comment?post_id=" + post_id + "&updated=no");
            }
        } else {
            response.sendRedirect("/comment?post_id=" + post_id + "&updated=no");
        }
    }
}
