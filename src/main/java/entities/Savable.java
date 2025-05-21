package entities;

import java.io.IOException;

public interface Savable {
    void saveToFile(String filename) throws IOException;
}

