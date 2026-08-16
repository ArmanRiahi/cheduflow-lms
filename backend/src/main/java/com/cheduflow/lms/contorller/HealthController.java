package com.cheduflow.lms.contorller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {
    
    @GetMapping("/api/heath")
    public String health() {
        return "ChEduFlow LMS is running!";
    }
}
