#let configuration = yaml("configuration.yaml")
#let settings = yaml("settings.yaml")

#show link: set text(blue)

#set page(
  paper: "a4",
  margin: (
    top: 1.5cm,
    bottom: 1cm,
    left: 2cm,
    right: 2cm,
  )
)

#show heading: h => [
  #set text(
    size: eval(settings.font.size.heading_large),
    font: settings.font.general
  )
  #h
]

#let sidebarSection = {[
  #set par(justify: true)

  #set text(
    size: eval(settings.font.size.contacts),
    font: settings.font.minor_highlight,
  )
      
  Email: #link("mailto:" + configuration.contacts.email) \
  Telefon: #link("tel:" + configuration.contacts.phone) \
  // LinkedIn: #link(configuration.contacts.linkedin.url)[#configuration.contacts.linkedin.displayText] \
  GitHub: #link(configuration.contacts.github.url)[#configuration.contacts.github.displayText] \
  
  // #configuration.contacts.address
  #line(length: 100%)

  // = Summary

  #set text(
      eval(settings.font.size.education_description),
      font: settings.font.minor_highlight,
  )
  Jsem student technické IT školy se zájmem o *nízkoúrovňové programování*, *programovací
  jazyky* a *operační systémy*.

  Programováním se zabývám už od základní školy jako jeden
  z mých koníčků a dokázal jsem se sám naučit mnohé technologie a své znalosti
  stále rozvíjím.

  Mezi mé další koníčky patří také horolezení a čtení knih.

  = Vzdělání
  #{
    for place in configuration.education [
        #par[
          #set text(
            size: eval(settings.font.size.heading),
            font: settings.font.general
          )
            #{
              if "to" in place and "from" in place [
                #place.from
                – #place.to \
              ] else if "arbitrary_interval" in place [
                #place.arbitrary_interval
              ]
            }
            #link(place.place.link)[#place.place.name]
        ]
        #par[
          #set text(
            eval(settings.font.size.education_description),
            font: settings.font.minor_highlight,
          )
          #{
            let description_items = ()
            if "degree" in place and "major" in place [
              #description_items.push(place.degree + " " + place.major)
            ]
            if "track" in place [
              #description_items.push(place.track)
            ]
            if "note" in place [
              #description_items.push(place.note)
            ]
            if "location" in place [
              #description_items.push(place.location)
            ]
            description_items.join("\n")
          }
        ]
    ]
  }

  = Jazyky
  #{
    for lang in configuration.languages [
      #par[
        #set text(
          size: eval(settings.font.size.description),
        )
        #set text(
          // size: eval(settings.font.size.tags),
          font: settings.font.minor_highlight,
        )
        *#lang.name* #h(1fr) #lang.level
      ]
    ]
  }

  = Certifikáty
  #{
    for cert in configuration.certificates [
      #par[#cert]
    ]
  }
]}

#let mainSection = {[
  #par[
    #set text(
      size: eval(settings.font.size.heading_huge),
      font: settings.font.title,
    )
    *#configuration.contacts.name*
  ]

  #par[
    #set text(
      size: eval(settings.font.size.heading),
      font: settings.font.subtitle,
      top-edge: 0pt
    )
    #configuration.contacts.title
  ]

  = Zkušenosti

  #{
    for job in configuration.jobs [
      #set par(justify: false)
      #set text(
        size: eval(settings.font.size.heading),
        font: settings.font.general
      )
      *#job.position* \
      #{
        if "company" in job [
          #link(job.company.link)[\@  #job.company.name]
        ]
        if "to" in job and "from" in job [
          #job.from – #job.to \
        ] else if "arbitrary_interval" in job [
          #job.arbitrary_interval \
        ]
      }

      #set text(
        size: eval(settings.font.size.description),
        font: settings.font.general
      )
      #list(..job.description)
    ]
  }

  = Dovednosti
  #{
    for skill in configuration.skills [
      #par[
        #set text(
          size: eval(settings.font.size.description),
          font: settings.font.minor_highlight,
        )
        #text(size: eval(settings.font.size.heading))[
          *#skill.name*
        ]
        #linebreak()
        #skill.items.join(" • ")
      ]
    ]
  }

  = Projekty

  #{
    for project in configuration.projects [
      #set par(justify: false)
      #set text(
        font: settings.font.general,
        size: eval(settings.font.size.description),
      )
      #text(
        size: eval(settings.font.size.heading),
      )[ *#project.name* - #project.language \ ]
      #list(..project.description)
    ]
  }
]}

#grid(
  columns: (2fr, 5fr),
  column-gutter: 3em,
  sidebarSection,
  mainSection,
)
