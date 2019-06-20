package model;

public class VoteOption {
    private String voteItem;
    private int optionId;
    private int themeId;
    private int count;

    public String getVoteItem() {
        return voteItem;
    }

    public void setVoteItem(String voteItem) {
        this.voteItem = voteItem;
    }

    public int getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = optionId;
    }

    public int getThemeId() {
        return themeId;
    }

    public void setThemeId(int themeId) {
        this.themeId = themeId;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
