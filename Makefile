OUT_DIR := out

all: $(OUT_DIR)/abus-72-40-bible-holder.stl $(OUT_DIR)/abus-72-40-cylinder-holder.stl

outDir:
	mkdir -p $(OUT_DIR)

clean:
	rm -rf $(OUT_DIR)

$(OUT_DIR)/%.stl : %.scad outDir
	openscad -o $@ $<
