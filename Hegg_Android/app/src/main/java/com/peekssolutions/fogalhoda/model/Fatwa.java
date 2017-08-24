package com.peekssolutions.fogalhoda.model;

/**
 * Created by khaled on 16/08/17.
 */

public class Fatwa {
    String question ;
    String answer;

    public Fatwa(String question, String answer) {
        this.question = question;
        this.answer = answer;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
