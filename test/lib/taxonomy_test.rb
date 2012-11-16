require_relative '../test_helper'
require 'taxonomy'

class TaxonomyTest < MiniTest::Unit::TestCase
  def test_load_taxonomy
    taxonomy = Taxonomy.load('test/fixtures/operating-systems.yml')
    # TODO
    #assert taxonomy[:debian]
    #assert taxonomy[:osx]
  end

  def test_classify_text
    os = Taxonomy.load('test/fixtures/operating-systems.yml')
    result = os.classify 'Debian is a Unix operating system, so are Ubuntu and OS X'
    assert result.include?("Debian"), result.inspect
    assert result.include?("OSX"), result.inspect
    assert result.include?("Ubuntu"), result.inspect
  end

  def test_classify_group
    os = Taxonomy.load('test/fixtures/operating-systems.yml')
    text = 'Debian is a Unix operating system, so are Ubuntu and OS X'
    result = os.classify text, group: 'Linux'
    assert result.include?("Debian"), result.inspect
    assert result.include?("Ubuntu"), result.inspect
    result = os.classify text, group: 'Mac'
    assert result.include?("OSX"), result.inspect
  end

  def test_classify_with_parent
    os = Taxonomy.load('test/fixtures/operating-systems.yml')
    text = 'Debian is a Unix operating system, so are Ubuntu and OS X'
    result = os.classify text, parent: 'Operating system'
    assert_equal ["Debian", "Ubuntu", "OSX"], result
    result = os.classify text, parent: 'Software'
    assert_equal ["Operating system"], result
  end

  def test_recursive_classify_with_parent
    flunk 'No support for recursive search yet. Could be implemented using recursion, nested sets or "Modified Preorder Tree Traversal."'
    os = Taxonomy.load('test/fixtures/operating-systems.yml')
    text = 'Debian is a Unix operating system, so are Ubuntu and OS X'
    result = os.classify text, parent: 'Operating system'
    assert_equal ["Debian", "Ubuntu", "OSX"], result
    result = os.classify text, parent: 'Software', recursive: true
    assert_equal ["Operating system", "Debian", "Ubuntu", "OSX"], result
  end
end
