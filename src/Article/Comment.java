package Article;

import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 */
public class Comment extends Text {
    protected List<Reply> replies;

    public Comment() {
    }

    public List<Reply> getReplies() {
        return replies;
    }

    public void setReplies(List<Reply> replies) {
        this.replies = replies;
    }
}
