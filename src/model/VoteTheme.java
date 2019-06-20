package model;

import java.util.List;
import java.util.Map;

/**
 * @author jacob
 */
public class VoteTheme {
    private int id;
    private String theme;
    private String info;
    private Map<String,Integer> options;
    private int censor;
    private List<VoteOption> allOptions;

    public int getCensor() {
        return censor;
    }

    public void setCensor(int censor) {
        this.censor = censor;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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

    public Map<String, Integer> getOptions() {
        return options;
    }

    public void setOptions(Map<String,Integer> options) {
        this.options = options;
    }

    public List<VoteOption> getAllOptions() {
        return allOptions;
    }

    public void setAllOptions(List<VoteOption> allOptions) {
        this.allOptions = allOptions;
    }
}
