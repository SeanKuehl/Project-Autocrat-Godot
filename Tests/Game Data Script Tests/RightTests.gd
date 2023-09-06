
extends GdUnitTestSuite

const helperFunctions = preload("res://Game Data Scripts/HelperFunctions.gd")

func test_firstRightName():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[0].GetName()
	var expected = "Legal Rights"
	
	assert_str(actual).is_equal(expected)
	
func test_firstRightOptions():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[0].GetOptions()
	var expected = ["No Rights", "Limited Rights", "Full Rights"]
	
	assert_array(actual).contains_same(expected)
	
func test_firstRightEffects():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[0].GetEffects()
	var expected = ["-5", "0", "5"]
	
	assert_array(actual).contains_same(expected)
	
func test_firstRightIndex():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[0].GetIndex()
	var expected = -1
	
	assert_int(actual).is_equal(expected)
	
func test_lastRightName():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[-1].GetName()
	var expected = "Higher Education"
	
	assert_str(actual).is_equal(expected)
	
func test_lastRightOptions():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[-1].GetOptions()
	var expected = ["Banned", "Limited Admittance", "Full Admittance"]
	
	assert_array(actual).contains_same(expected)
	
func test_lastRightEffects():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[-1].GetEffects()
	var expected = ["-5", "0", "5"]
	
	assert_array(actual).contains_same(expected)
	
func test_lastRightIndex():
	var test = helperFunctions.new()
	test = test.LoadRightsFromFile()
	
	var actual = test[-1].GetIndex()
	var expected = -1
	
	assert_int(actual).is_equal(expected)
