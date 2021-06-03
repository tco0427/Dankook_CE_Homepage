package action.post;

import action.Action;
import dao.PostRepository;
import dao.PostRepositoryImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PostDeleteAction implements Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) {
        Integer id=null;
        try{
            id=Integer.parseInt(request.getParameter("id"));
        }catch(NumberFormatException e){
            id=null;
        }
        System.out.println("id: "+id);
        PostRepository postRepository= PostRepositoryImpl.getInstance();
        int code=postRepository.delete(id);
        request.setAttribute("errorCode",code);
    }
}
