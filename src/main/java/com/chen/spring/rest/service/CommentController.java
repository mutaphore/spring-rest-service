package com.chen.spring.rest.service;
import com.chen.spring.rest.model.Comment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.Date;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

@RequestMapping("/comment/**")
@Controller
@RooWebScaffold(path = "comment", formBackingObject = Comment.class)
@RooWebJson(jsonObject = Comment.class)
public class CommentController {

    @RequestMapping(value = "/comment/test", method = RequestMethod.GET)
    @ResponseBody
    public String doTest() {
        String testStr = "Comment test worked!";
        return testStr;
    }

    @RequestMapping(value = "/comment/test2/{id}", method = RequestMethod.GET)
    public ResponseEntity<String> doTest2(@PathVariable Long id) {
        if (id == null) {
            return new ResponseEntity<String>("Comment test 2 worked! No id. ", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("Comment test 2 worked! Id was: " + id, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "/comment/add", method = RequestMethod.POST, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> addComment(@RequestBody String json) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        try {
            Comment comment = Comment.fromJsonToComment(json);
            if (comment.getCommentDate() == null) {
                comment.setCommentDate(new Date());
            }
            comment.persist();
            System.out.println("New comment added, id = " + comment.getId());
            return new ResponseEntity<String>(headers, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
