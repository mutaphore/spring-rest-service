package com.chen.spring.rest.service;
import com.chen.spring.rest.model.ClickEvent;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Date;

@RequestMapping("/click_event/**")
@Controller
@RooWebScaffold(path = "click_event", formBackingObject = ClickEvent.class)
@RooWebJson(jsonObject = ClickEvent.class)
public class ClickEventController {

    @RequestMapping(value = "/click_event/test", method = RequestMethod.GET)
    public ResponseEntity<ClickEvent> doTest() {
        ClickEvent test = new ClickEvent();
        test.setId(123L);
        test.setClickDate(new Date());
        test.setDescription("This is a test Click Event object");
        return new ResponseEntity<ClickEvent>(test, HttpStatus.OK);
    }

    /**
     * Ajax request to add a click event
     * @param json
     * @return
     */
    @RequestMapping(value = "/click_event/add", method = RequestMethod.POST, headers = "Accept=application/json")
    public ResponseEntity<String> addClickEventJson(@RequestBody String json) {
        HttpHeaders headers = new HttpHeaders();
        try {
            headers.add("Content-Type", "application/json");
            ClickEvent event = ClickEvent.fromJsonToClickEvent(json);
            if (event.getClickDate() == null) {
                event.setClickDate(new Date());
            }
            event.persist();
            return new ResponseEntity<String>(event.toJson(), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
