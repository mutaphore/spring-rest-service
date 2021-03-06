// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.chen.spring.rest.service;

import com.chen.spring.rest.model.ClickEvent;
import com.chen.spring.rest.service.ClickEventController;
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

privileged aspect ClickEventController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String ClickEventController.create(@Valid ClickEvent clickEvent, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, clickEvent);
            return "click_event/create";
        }
        uiModel.asMap().clear();
        clickEvent.persist();
        return "redirect:/click_event/" + encodeUrlPathSegment(clickEvent.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String ClickEventController.createForm(Model uiModel) {
        populateEditForm(uiModel, new ClickEvent());
        return "click_event/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String ClickEventController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("clickevent", ClickEvent.findClickEvent(id));
        uiModel.addAttribute("itemId", id);
        return "click_event/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String ClickEventController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("clickevents", ClickEvent.findClickEventEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) ClickEvent.countClickEvents() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("clickevents", ClickEvent.findAllClickEvents(sortFieldName, sortOrder));
        }
        addDateTimeFormatPatterns(uiModel);
        return "click_event/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String ClickEventController.update(@Valid ClickEvent clickEvent, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, clickEvent);
            return "click_event/update";
        }
        uiModel.asMap().clear();
        clickEvent.merge();
        return "redirect:/click_event/" + encodeUrlPathSegment(clickEvent.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String ClickEventController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, ClickEvent.findClickEvent(id));
        return "click_event/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String ClickEventController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        ClickEvent clickEvent = ClickEvent.findClickEvent(id);
        clickEvent.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/click_event";
    }
    
    void ClickEventController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("clickEvent_clickdate_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    void ClickEventController.populateEditForm(Model uiModel, ClickEvent clickEvent) {
        uiModel.addAttribute("clickEvent", clickEvent);
        addDateTimeFormatPatterns(uiModel);
    }
    
    String ClickEventController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
