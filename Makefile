#current = cara_resume
#current = travis_academia_cv
#current = travis_teaching_philosophy
#current = travis_curriculum_contribution
#current = travis_publication_list
#current = travis_academia_contacts
#current = travis_research_statment_exec
current = travis_research_statment

all:
	@make check
	make $(current)
	evince pdf/$(current).pdf & 2>/dev/null 

master:
	make prof_ts 
	make prof_rs
	make travis

$(current):
	pdflatex -output-directory pdf $(current).tex

travis_publication_list:
	pdflatex -output-directory pdf travis_publication_list.tex
	cp bibliography/*.bib pdf
	cd pdf; bibtex travis_publication_list
	pdflatex -output-directory pdf travis_publication_list.tex

travis_academia_cv:
	pdflatex -output-directory pdf travis_academia_cv.tex

travis_academia_contacts:
	pdflatex -output-directory pdf travis_academia_contacts.tex

travis_research_statment_exec:
	pdflatex -output-directory pdf travis_research_statment_exec

travis_research_statment:
	pdflatex -output-directory pdf travis_research_statment

travis_teaching_philosophy:
	pdflatex -output-directory pdf travis_teaching_philosophy.tex

travis_curriculum_contribution:
	pdflatex -output-directory pdf travis_curriculum_contribution.tex

cara_resume:
	pdflatex -output-directory pdf cara_resume.tex

edit:
	emacs $(current).tex &

check:
	aspell -t -c $(current).tex

bib:
	pdflatex $(current).tex
	bibtex $(current)
	pdflatex $(current).txe
	evince $(current).pdf & 2>/dev/null 

clean:
	find . -name "*~" -exec rm -vf {} \;
	find pdf ! -iname "README.md" -type f -exec rm -vf {} +
	rm -vfr auto/

push:
	git commit -a
	git push

commit:
	make push
