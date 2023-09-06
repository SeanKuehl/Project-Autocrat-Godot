class_name GdUnitExampleTest
extends GdUnitTestSuite

const helperFunctions = preload("res://Game Data Scripts/HelperFunctions.gd")

func test_firstSelectionName():
	var test = helperFunctions.new()
	test = test.LoadSelectionsFromFile()
	
	var actual = test[0].GetName()
	var expected = "Genders"
	
	assert_str(actual).is_equal(expected)
	
func test_firstSelectionOptions():
	var test = helperFunctions.new()
	test = test.LoadSelectionsFromFile()
	
	var actual = test[0].GetOptions()
	var expected = ["Male", "Female"]
	
	assert_array(actual).contains_same(expected)
	
func test_firstSelectionChoices():
	var test = helperFunctions.new()
	test = test.LoadSelectionsFromFile()
	
	var actual = test[0].GetChoices()
	var expected = [0, 0]
	
	assert_array(actual).contains_same(expected)
	
	
	
func test_lastSelectionName():
	var test = helperFunctions.new()
	test = test.LoadSelectionsFromFile()
	
	var actual = test[len(test)-1].GetName()
	var expected = "Income Ranges"
	
	assert_str(actual).is_equal(expected)
	
func test_lastSelectionOptions():
	var test = helperFunctions.new()
	test = test.LoadSelectionsFromFile()
	
	var actual = test[len(test)-1].GetOptions()
	var expected = ["Destitute", "Poor", "Middle Class", "Wealthy", "Ultra Wealthy"]
	
	assert_array(actual).contains_same(expected)
	
func test_lastSelectionChoices():
	var test = helperFunctions.new()
	test = test.LoadSelectionsFromFile()
	
	var actual = test[len(test)-1].GetChoices()
	var expected = [0, 0, 0, 0, 0]
	
	assert_array(actual).contains_same(expected)

