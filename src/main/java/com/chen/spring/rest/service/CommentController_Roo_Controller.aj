// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.chen.spring.rest.service;

import com.chen.spring.rest.model.Comment;
import com.chen.spring.rest.service.CommentController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect CommentController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String CommentController.create(@Valid Comment comment, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, comment);
            return "comment/create";
        }
        uiModel.asMap().clear();
        comment.persist();
        return "redirect:/comment/" + encodeUrlPathSegment(comment.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String CommentController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Comment());
        return "comment/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String CommentController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("comment", Comment.findComment(id));
        uiModel.addAttribute("itemId", id);
        return "comment/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String CommentController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("comments", Comment.findCommentEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Comment.countComments() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("comments", Comment.findAllComments(sortFieldName, sortOrder));
        }
        addDateTimeFormatPatterns(uiModel);
        return "comment/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String CommentController.update(@Valid Comment comment, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, comment);
            return "comment/update";
        }
        uiModel.asMap().clear();
        comment.merge();
        return "redirect:/comment/" + encodeUrlPathSegment(comment.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String CommentController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Comment.findComment(id));
        return "comment/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String CommentController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Comment comment = Comment.findComment(id);
        comment.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/comment";
    }
    
    void CommentController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("comment_commentdate_date_format", DateTimeFormat.patternForStyle("LL", LocaleContextHolder.getLocale()));
    }
    
    void CommentController.populateEditForm(Model uiModel, Comment comment) {
        uiModel.addAttribute("comment", comment);
        addDateTimeFormatPatterns(uiModel);
    }
    
    String CommentController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
