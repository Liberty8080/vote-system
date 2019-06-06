package model;

import java.util.ArrayList;
import java.util.List;

/**
 * @author jacob
 */
public class VoteTheme {
    private String theme;
    private String info;
    private List<String> options;
    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public List<String> getOptions(){
        return options;
    }

    public void setOptions(List<String> options){
        this.options = options;
    }
}
